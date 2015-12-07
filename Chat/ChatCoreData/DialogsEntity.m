//
//  DialogsEntity.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogsEntity.h"
#import "DialogEntity.h"

@implementation DialogsEntity

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    DialogsEntity *dialogs = [DialogsEntity MR_createEntity];
    for (NSDictionary *dialogsDic in [dictionary valueForKey:@"dialogs"]) {
        DialogEntity *dialog = [[DialogEntity MR_createEntity]initClassWithDictionary:dialogsDic];
        [dialogs addDialogRSObject:dialog];
    }
    return self;
}

@end
