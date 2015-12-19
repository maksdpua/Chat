//
//  MessagePhoto.m
//  Chat
//
//  Created by Maks on 12/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MessagePhoto.h"
#import "MessageEntity.h"

@implementation MessagePhoto

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"message_photo_height" : @"messagePhotoHeight", @"message_photo_id" : @"messagePhotoID", @"message_photo_original" : @"messagePhotoOriginal", @"message_photo_tabneil" : @"messagePhotoTabneil", @"message_photo_width" : @"messagePhotoWidth"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    NSString *messagePhotoString = [NSString stringWithFormat:@"%@", [dictionary valueForKey:@"message_photo_id"]];
    
    id obj = [MessagePhoto MR_findFirstByAttribute:@"messagePhotoID" withValue:messagePhotoString];
    if (obj) {
        self = obj;
    } else {
        self = [MessagePhoto MR_createEntity];
    }
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    
    return self;
}

@end
