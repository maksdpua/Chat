//
//  UserProfile.h
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userLastName;
@property (nonatomic, readonly) NSString *userPhone;
@property (nonatomic, readonly) NSString *userAvatar;
@property (nonatomic, readonly) NSString *isFriend;
@property (nonatomic, readonly) NSString *userEmail;
@property (nonatomic, readonly) NSString *userBirthday;
@property (nonatomic, readonly) NSString *userHometown;
@property (nonatomic, readonly) NSString *userFavourite;
@property (nonatomic, readonly) NSString *userUnivercity;
@property (nonatomic, readonly) NSNumber *isMale;

//- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

/*
    "result": true,
    "user_info": {
        "user_id": 6,
        "username": "Іван",
        "lastname": "(basic registration)",
        "email": "support@webstorinka.biz",
        "gender": true,
        "city": "Тернопіль",
        "hometown": "",
        "avatar": "",
        "avatar_tabneil": "",
        "count_mark": 0,
        "birthday": "10.09.1980",
        "count_photo": 0,
        "count_response": 0,
        "count_news": 1,
        "online": false,
        "family_status": "",
        "work_place": "",
        "work_position": "",
        "about_me": "",
        "favourite": "",
        "university": "",
        "school": "",
        "phone": "380673501412",
        "count_friend": "2",
        "friend": true,
        "blocked": true
    }
*/


@end
