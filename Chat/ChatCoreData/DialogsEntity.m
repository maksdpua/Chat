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
    id obj = [DialogsEntity MR_findFirst];
    
    if (obj) {
        self = obj;
    } else {
        self = [DialogsEntity MR_createEntity];
    }
    for (NSDictionary *dialogDictionary in [dictionary valueForKey:@"dialogs"]) {
        __unused DialogEntity *dialog = [[DialogEntity alloc] initClassWithDictionary:dialogDictionary];
    }
    
    self.dialogRS = [NSSet new];
    for (DialogEntity *d in [DialogEntity MR_findAll]) {
        [self addDialogRSObject:d];
    }

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    return self;
}
@end
