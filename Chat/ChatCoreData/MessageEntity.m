//
//  MessageEntity.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MessageEntity.h"
#import "DialogEntity.h"

@implementation MessageEntity

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"dialog_id" : @"dialogID", @"friend": @"isFriend", @"message_text": @"messageText", @"message_date": @"messageDate", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    
    for (NSDictionary *messagesDic in [dictionary valueForKey:@"messages"]) {
        DialogEntity *findedDialog = [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:[NSString stringWithFormat:@"%@", [messagesDic valueForKey:@"dialog_id"] ]];
        if (![MessageEntity MR_findFirstByAttribute:@"dialogID" withValue:[NSString stringWithFormat:@"%@",[messagesDic valueForKey:@"dialog_id"]]] || ![MessageEntity MR_findFirstByAttribute:@"messageDate" withValue:[NSString stringWithFormat:@"%@", [messagesDic valueForKey:@"message_date"]]]) {
            MessageEntity *message = [[MessageEntity MR_createEntity] loadClassWithDictionary:messagesDic InstructionDictionary:[self dictionaryInstructionManager]];
            [findedDialog addMessageRSObject:message];
        }
        
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
//    [MessageEntity MR_truncateAll];
    return self;
}

@end
