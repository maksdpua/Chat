//
//  UserFriendList.m
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "Friends.h"
#import "User.h"

@interface Friends()

@property (nonatomic, readwrite) NSMutableArray *array;

@end

@implementation Friends

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self.array = [NSMutableArray new];
    for (NSDictionary *userDictionary in [dictionary valueForKey:@"friends"]) {
        User *user = [[User alloc]initClassWithDictionary:userDictionary];
        [self.array addObject:user];
    }
    return self;
}

@end
