//
//  SPUserProfile.h
//  SocketProject
//
//  Created by Genrih Korenujenko on 09.11.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userEmail;
@property (nonatomic, readonly) NSString *userBirthday;
@property (nonatomic, readonly) NSString *userAvatar;

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;


//"user_id": 20166,
//"username": "Vasyl",
//"lastname": null,
//"email": "vasiji95@gmail.com",
//"gender": null,
//"city": "",
//"hometown": "",
//"avatar": "",
//"avatar_tabneil": "",
//"count_mark": 0,
//"birthday": "31.10.1994",
//"count_photo": 0,
//"count_response": 0,
//"count_news": 0,
//"online": true,
//"family_status": "",
//"work_place": "",
//"work_position": "",
//"about_me": "",
//"favourite": "",
//"university": "",
//"school": "",
//"phone": "",
//"dialogs_count": "0",
//"count_friend": "0"

@end
