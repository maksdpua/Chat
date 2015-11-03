//
//  MessageObject.h
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *recipientID;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;

@end
