//
//  DialogEntity.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogEntity.h"
#import "DialogsEntity.h"
#import "MessageEntity.h"

@implementation DialogEntity

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"friend": @"isFriend", @"message_text": @"messageText", @"message_date": @"messageDate", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

@end
