//
//  SendMessageForm.h
//  Chat
//
//  Created by Maks on 11/25/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SendMessageForm : UIView

- (instancetype)initOnView:(UIView *)view withUser:(User *)user;

@end
