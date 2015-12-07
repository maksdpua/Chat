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
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"friend": @"isFriend", @"message_text": @"messageText", @"message_date": @"messageDate", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {

    for (NSDictionary *messagesDic in [dictionary valueForKey:@"messages"]) {
        
        MessageEntity *message = [MessageEntity MR_createEntity];
        message = [super loadClassWithDictionary:messagesDic InstructionDictionary:[self dictionaryInstructionManager]];
        DialogEntity *dialog = [DialogEntity MR_findFirstByAttribute:@"userID"
                                                     withValue:message.userID];
        [dialog addMessageRSObject:message];
        
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    return self;
}

@end
