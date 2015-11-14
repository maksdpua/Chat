//
//  SPUserProfile.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 09.11.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"username" : @"userName", @"email" : @"userEmail", @"birthday" : @"userBirthday"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:[dictionary valueForKey:@"user_info"] InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

@end
