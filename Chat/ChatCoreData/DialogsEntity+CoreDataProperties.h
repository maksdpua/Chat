//
//  DialogsEntity+CoreDataProperties.h
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DialogsEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface DialogsEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<DialogEntity *> *dialogRS;

@end

@interface DialogsEntity (CoreDataGeneratedAccessors)

- (void)addDialogRSObject:(DialogEntity *)value;
- (void)removeDialogRSObject:(DialogEntity *)value;
- (void)addDialogRS:(NSSet<DialogEntity *> *)values;
- (void)removeDialogRS:(NSSet<DialogEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
