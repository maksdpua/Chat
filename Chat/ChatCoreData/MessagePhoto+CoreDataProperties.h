//
//  MessagePhoto+CoreDataProperties.h
//  Chat
//
//  Created by Maks on 12/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MessagePhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessagePhoto (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *messagePhotoHeight;
@property (nullable, nonatomic, retain) NSString *messagePhotoID;
@property (nullable, nonatomic, retain) NSString *messagePhotoOriginal;
@property (nullable, nonatomic, retain) NSString *messagePhotoTabneil;
@property (nullable, nonatomic, retain) NSString *messagePhotoWidth;
@property (nullable, nonatomic, retain) MessageEntity *messageRS;

@end

NS_ASSUME_NONNULL_END
