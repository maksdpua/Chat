//
//  DialogsEntity.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogsEntity.h"
#import "DialogEntity.h"

@implementation DialogsEntity {
    DialogsEntity *dialogs;
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    
    if (![[DialogsEntity MR_findAll] firstObject]) {
        dialogs = [DialogsEntity MR_createEntity];
        for (NSDictionary *dialogsDic in [dictionary valueForKey:@"dialogs"]) {
            DialogEntity *dialog = [[DialogEntity MR_createEntity]initClassWithDictionary:dialogsDic];
            [dialogs addDialogRSObject:dialog];
        }
    } else {
        for (NSDictionary *dialogDictionary in [dictionary valueForKey:@"dialogs"]) {
            
            if (![DialogEntity MR_findFirstByAttribute:@"dialogID"
                                             withValue:[NSString stringWithFormat:@"%@",[dialogDictionary valueForKey:@"dialog_id"]]] || ![DialogEntity MR_findFirstByAttribute:@"messageDate" withValue:[NSString stringWithFormat:@"%@",[dialogDictionary valueForKey:@"message_date"]]]) {
                [[DialogEntity MR_findFirstByAttribute:@"dialogID"
                                             withValue:[NSString stringWithFormat:@"%@",[dialogDictionary valueForKey:@"dialog_id"]]] MR_deleteEntity];
                DialogEntity *dialogToCreate = [[DialogEntity MR_createEntity]initClassWithDictionary:dialogDictionary];
                [[[DialogsEntity MR_findAll] firstObject] addDialogRSObject:dialogToCreate];
            }
        }
    }
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    return self;
}
@end
