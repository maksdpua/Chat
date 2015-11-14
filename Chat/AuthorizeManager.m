//
//  AuthorizeManager.m
//  Chat
//
//  Created by Maks on 11/13/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "AuthorizeManager.h"

static AuthorizeManager *authorization = nil;

@implementation AuthorizeManager

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_session_hash" : @"sessionHash"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    if (!authorization) {
        [AuthorizeManager sharedAuthorization];
        authorization = self;
    }
    
    return self;
}

+ (instancetype)sharedAuthorization {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authorization = [[AuthorizeManager alloc] init];
        authorization.userID = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"];
        authorization.sessionHash = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_session_hash"];
    });
    return authorization;
}

+ (NSString *)userID {
    return authorization.userID;
}

+ (NSString *)sessionHash {
    return authorization.sessionHash;
}



@end
