//
//  DialogEntity+CoreDataProperties.m
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DialogEntity+CoreDataProperties.h"

@implementation DialogEntity (CoreDataProperties)

@dynamic userID;
@dynamic messageText;
@dynamic userAvatar;
@dynamic userThumbnailAvatar;
@dynamic userName;
@dynamic isFriend;
@dynamic online;
@dynamic didRead;
@dynamic messageDate;
@dynamic messageRS;
@dynamic dialogsRS;

@end
