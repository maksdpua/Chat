//
//  Messages.m
//  Chat
//
//  Created by Maks on 11/26/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "Messages.h"
#import "User.h"

@interface Messages()

@property (nonatomic, readwrite) NSMutableArray *array;

@end

@implementation Messages

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self.array = [NSMutableArray new];
    for (NSDictionary *userDictionary in [dictionary valueForKey:@"messages"]) {
        User *user = [[User alloc]initClassWithDictionary:userDictionary];
        [self.array addObject:user];
    }
    return self;
}
@end
