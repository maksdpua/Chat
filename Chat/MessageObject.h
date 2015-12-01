//
//  MessageObject.h
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject

@property (nonatomic, readonly) NSString *userID;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userLastName;

@property (nonatomic, readonly) NSString *userAvatar;

@property (nonatomic,readonly) NSString *recipientID;
@property (nonatomic,readonly) NSString *messageText;
@property (nonatomic,readonly) NSString *messagePhoto;
@property (nonatomic, readonly) NSString *recipientNewMessages;

@end
