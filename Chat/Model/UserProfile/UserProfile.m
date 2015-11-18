//
//  UserProfile.m
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"username" : @"userName", @"lastname" : @"userLastName", @"avatar" : @"userAvatar", @"friend": @"isFriend"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:[dictionary valueForKey:@"user_info"] InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

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
