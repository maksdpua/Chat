//
//  UserFriendList.m
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserFriendList.h"
#import "User.h"

@interface UserFriendList()

@property (nonatomic, readwrite) NSMutableArray *friendsArray;

@end

@implementation UserFriendList

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self.friendsArray = [NSMutableArray new];
    for (NSDictionary *userDictionary in [dictionary valueForKey:@"users"]) {
        User *user = [[User alloc]initClassWithDictionary:userDictionary];
        [self.friendsArray addObject:user];
    }
    return self;
}

@end
