//
//  MessageEntity.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MessageEntity.h"
#import "DialogEntity.h"
#import "MessagePhoto.h"


@implementation MessageEntity

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_lastname" : @"userLastName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"dialog_id" : @"dialogID", @"friend": @"isFriend", @"message_text": @"messageText",@"message_date": @"messageDate", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    
    for (NSDictionary *messagesDic in [dictionary valueForKey:@"messages"]) {
        
        DialogEntity *findedDialog = [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:[NSString stringWithFormat:@"%@", [messagesDic valueForKey:@"dialog_id"] ]];
        
        if (![MessageEntity MR_findFirstByAttribute:@"dialogID" withValue:[NSString stringWithFormat:@"%@",[messagesDic valueForKey:@"dialog_id"]]] || ![MessageEntity MR_findFirstByAttribute:@"messageDate" withValue:[NSString stringWithFormat:@"%@", [messagesDic valueForKey:@"message_date"]]]) {
            
            MessageEntity *message = [[MessageEntity MR_createEntity] loadClassWithDictionary:messagesDic InstructionDictionary:[self dictionaryInstructionManager]];
            
            message.messagePhotoRS = [NSSet new];
            if ([[messagesDic valueForKey:@"message_photo"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *photoDic in [messagesDic valueForKey:@"message_photo"]) {
                    MessagePhoto *photo = [[MessagePhoto alloc] initClassWithDictionary:photoDic];
                    [message addMessagePhotoRSObject:photo];
                }
            }
            [findedDialog addMessageRSObject:message];
        }
        
    }
    
//    for (NSDictionary *message in [dictionary valueForKey:@"messages"]) {
//        id obj = [MessageEntity MR_findFirstByAttribute:@"messageDate" withValue:[NSString stringWithFormat:@"%@", [message valueForKey:@"message_date"]]];
//        if (obj) {
//            self = obj;
//        } else {
//            self = [MessageEntity MR_createEntity];
//        }
//        self = [super loadClassWithDictionary:message InstructionDictionary:[self dictionaryInstructionManager]];
//    }
//    [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:[dictionary valueForKey:@"dialog_id"]].messageRS = [NSSet new];
//    for (MessageEntity *message in *Найти все сообщения с заданным *) {
//        
//    }
    


    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    return self;
}

@end
