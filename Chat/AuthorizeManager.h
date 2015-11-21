//
//  AuthorizeManager.h
//  Chat
//
//  Created by Maks on 11/13/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * userIDKey = @"userId";
static NSString * sessionHashKey = @"usersessionhash";

@interface AuthorizeManager : NSObject

//@property (nonatomic, readwrite) NSString *userID;
//@property (nonatomic, readwrite) NSString *sessionHash;

//- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

//+ (instancetype)sharedAuthorization;

+ (NSString *)userID;
+ (NSString *)sessionHash;

+ (void)removeUserIdAndSessionHashData;

@end
