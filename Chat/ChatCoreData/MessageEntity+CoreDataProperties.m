//
//  MessageEntity+CoreDataProperties.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MessageEntity+CoreDataProperties.h"

@implementation MessageEntity (CoreDataProperties)

@dynamic userID;
@dynamic userThumbnailAvatar;
@dynamic userAvatar;
@dynamic userName;
@dynamic didRead;
@dynamic dialogID;
@dynamic userLastName;
@dynamic messageText;
@dynamic messageDate;
@dynamic dialogRS;
@dynamic online;

@end
