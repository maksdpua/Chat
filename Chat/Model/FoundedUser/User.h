//
//  FoundedUser.h
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userLastName;
@property (nonatomic, readonly) NSString *thumb;
@property (nonatomic, readonly) NSString *online;
@property (nonatomic, readonly) NSString *isFriend;
@property (nonatomic, readonly) NSString *userThumbnailAvatar;
@property (nonatomic, readonly) NSString *userAvatar;

@property (nonatomic,readonly) NSString *dialogID;
@property (nonatomic,readonly) NSString *messageID;
@property (nonatomic,readonly) NSString *senderID;
@property (nonatomic,readonly) NSString *recipientID;
@property (nonatomic,readonly) NSString *messageText;
@property (nonatomic,readonly) NSString *messagePhoto;
@property (nonatomic, readonly) NSString *didRead;


//- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

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

//"result": true,
//"dialogs": [
//            {
//                "user_id": 52,
//                "user_name": "Иоhhh",
//                "user_lastname": "Ооbbh",
//                "user_avatar": "",
//                "user_thumbnail_avatar": "",
//                "user_online": false,
//                "user_birthday": "14.01.2015",
//                "user_hometown": "",

//                "dialog_id": 74,
//                "message_id": 1100,
//                "sender_id": 52,
//                "recipient_id": 6,
//                "message_text": "456465",
//                "message_photo": "",
//                "did_read": 0,
//                "message_date": 1441758588
//            },
//            …
//            ],
//"did_read": 0,
//"message_date": 1437560220

@end
