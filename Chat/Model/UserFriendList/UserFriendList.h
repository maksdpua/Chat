//
//  UserFriendList.h
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserFriendList : NSObject

@property (nonatomic, readonly) NSMutableArray *friendsArray;

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

@end
