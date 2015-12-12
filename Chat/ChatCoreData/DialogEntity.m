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
    return @{@"user_id" : @"userID", @"user_name" : @"userName", @"user_thumbnail_avatar" : @"userThumbnailAvatar", @"user_avatar" : @"userAvatar", @"user_online" : @"online", @"friend": @"isFriend", @"dialog_id" : @"dialogID",@"message_text": @"messageText", @"message_date": @"messageDate", @"did_read": @"didRead"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    NSString *dialogidString = [NSString stringWithFormat:@"%@", [dictionary valueForKey:@"dialog_id"]];
    
    id obj = [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:dialogidString];
    if (obj) {
        self = obj;
    } else {
        self = [DialogEntity MR_createEntity];
    }
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    
    return self;
}

@end
