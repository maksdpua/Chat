//
//  FoundedUser.h
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundedUser : NSObject

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userLastName;
@property (nonatomic, readonly) NSString *avatar;
@property (nonatomic, readonly) NSString *online;

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

//"users": [
//          {
//              "user_id": 22,
//              "user_name": "Test",
//              "user_lastname": "Test",
//              "user_avatar": "",
//              "user_thumbnail_avatar": "",
//              "user_online": false,
//              "user_birthday": "23.10.1988",
//              "user_hometown": "",
//              "friend": false
//          }


@end
