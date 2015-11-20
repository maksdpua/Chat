//
//  UserFriendList.h
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friends : NSObject

@property (nonatomic, readonly) NSMutableArray *array;

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

@end
