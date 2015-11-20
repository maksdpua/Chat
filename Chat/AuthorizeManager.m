//
//  AuthorizeManager.m
//  Chat
//
//  Created by Maks on 11/13/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "AuthorizeManager.h"

//static AuthorizeManager *authorization = nil;

@implementation AuthorizeManager

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    
//    self = [super loadClassWithDictionary:dictionary InstructionDictionary:@{}];
    if (![AuthorizeManager userID] && ![AuthorizeManager sessionHash]) {
        [[NSUserDefaults standardUserDefaults]setObject:[dictionary valueForKey:@"user_id"] forKey:userIDKey];
        [[NSUserDefaults standardUserDefaults]setObject:[dictionary valueForKey:@"user_session_hash"] forKey:sessionHashKey];
    }
//    if (!authorization) {
//        [AuthorizeManager sharedAuthorization];
//        authorization = self;
//    }
    return self;
}

//+ (instancetype)sharedAuthorization {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        authorization = [[AuthorizeManager alloc] init];
//    });
//    return authorization;
//}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.userID = [[NSUserDefaults standardUserDefaults]stringForKey:userIDKey];
//        self.sessionHash = [[NSUserDefaults standardUserDefaults]stringForKey:sessionHashKey];
//    }
//    return self;
//}

+ (NSString *)userID {
    return [[NSUserDefaults standardUserDefaults]stringForKey:userIDKey];
}

+ (NSString *)sessionHash {
    return [[NSUserDefaults standardUserDefaults]stringForKey:sessionHashKey];
}

+ (void)removeUserIdAndSessionHashData {
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:userIDKey];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:sessionHashKey];
}



@end
