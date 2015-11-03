//
//  ChatCell.h
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"

static NSInteger leftX = 8;

@interface ChatCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelCell;
@property IBOutlet NSLayoutConstraint *leftConstaint;
@property IBOutlet NSLayoutConstraint *rightConstaint;

- (void)loadWithFrame:(CGRect)rect;

- (void)initWithMessage:(MessageObject *)message;

- (CGSize)heightForRowFromMessageObject:(MessageObject *)messageObject;

- (void)cellFromMessage:(MessageObject *)messageObject;

- (void)loadWithMessageObject: (MessageObject*)messageObject;

@end
