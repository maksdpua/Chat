//
//  MessageEntity+CoreDataProperties.h
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MessageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSString *userThumbnailAvatar;
@property (nullable, nonatomic, retain) NSString *userAvatar;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *didRead;
@property (nullable, nonatomic, retain) NSString *dialogID;
@property (nullable, nonatomic, retain) NSString *userLastName;
@property (nullable, nonatomic, retain) NSString *messageText;
@property (nullable, nonatomic, retain) NSString *messageDate;
@property (nullable, nonatomic, retain) NSString *online;
@property (nullable, nonatomic, retain) DialogEntity *dialogRS;

@end

NS_ASSUME_NONNULL_END
