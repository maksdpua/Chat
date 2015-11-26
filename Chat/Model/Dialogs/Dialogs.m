//
//  Dialogs.m
//  Chat
//
//  Created by Maks on 11/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "Dialogs.h"
#import "User.h"

@interface Dialogs()

@property (nonatomic, readwrite) NSMutableArray *array;

@end

@implementation Dialogs

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self.array = [NSMutableArray new];
    for (NSDictionary *userDictionary in [dictionary valueForKey:@"dialogs"]) {
        User *user = [[User alloc]initClassWithDictionary:userDictionary];
        [self.array addObject:user];
    }
    return self;
}

@end
