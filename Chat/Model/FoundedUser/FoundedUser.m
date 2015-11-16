//
//  FoundedUser.m
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "FoundedUser.h"

@implementation FoundedUser

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"avatar", @"user_online" : @"online"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}


@end
