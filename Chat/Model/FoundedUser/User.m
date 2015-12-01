//
//  FoundedUser.m
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "User.h"

@implementation User

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"friend": @"isFriend",@"dialog_id": @"dialogID", @"message_id": @"messageID", @"sender_id": @"senderID", @"recipient_id": @"recipientID", @"message_text": @"messageText", @"message_photo": @"messagePhoto", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}


@end
