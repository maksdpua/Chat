//
//  SPUserProfile.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 09.11.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"username" : @"userName",@"lastname" : @"userLastname", @"email" : @"userEmail", @"birthday" : @"userBirthday", @"avatar" : @"userAvatar", @"phone" : @"userPhone", @"favourite" : @"userFavourite", @"university" : @"userUnivercity", @"hometown" : @"userHometown", @"gender" : @"isMale"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:[dictionary valueForKey:@"user_info"] InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

@end
