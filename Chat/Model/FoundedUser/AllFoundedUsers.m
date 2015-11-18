//
//  Users.m
//  Chat
//
//  Created by Maks on 11/16/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "AllFoundedUsers.h"
#import "User.h"

@interface AllFoundedUsers()

@property (nonatomic, readwrite) NSMutableArray *array;

@end

@implementation AllFoundedUsers 

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
        self.array = [NSMutableArray new];
    for (NSDictionary *user in [dictionary valueForKey:@"users"]) {
        User *foundedUser = [[User alloc]initClassWithDictionary:user];
        [self.array addObject:foundedUser];
    }
    return self;
}

@end
