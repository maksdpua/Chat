//
//  ChatCell.h
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"
#import "User.h"

static NSInteger leftX = 8;

@interface ChatCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelCell;
@property IBOutlet NSLayoutConstraint *leftConstaint;
@property IBOutlet NSLayoutConstraint *rightConstaint;



- (void)loadWithFrame:(CGRect)rect;

- (void)initWithMessage:(User *)message;

- (CGSize)heightForRowFromMessageObject:(User *)messageObject;

- (void)cellFromMessage:(User *)messageObject;

- (void)loadWithMessageObject:(User*)messageObject;

@end
