//
//  MessageEntity.h
//  Chat
//
//  Created by Maks on 12/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DialogEntity, MessagePhoto;

NS_ASSUME_NONNULL_BEGIN

@interface MessageEntity : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "MessageEntity+CoreDataProperties.h"
