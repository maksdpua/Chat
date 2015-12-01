//
//  MessageObject.m
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MessageObject.h"

@implementation MessageObject

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_avatar" : @"userAvatar",  @"recipient_id": @"recipientID", @"message_text": @"messageText", @"message_photo": @"messagePhoto", @"recipient_new_messages": @"recipientNewMessages"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

@end
