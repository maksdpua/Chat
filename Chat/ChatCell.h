//
//  ChatCell.h
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"
#import "MessageEntity.h"

static NSInteger leftX = 8;

@interface ChatCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelCell;
@property (nonatomic, weak) IBOutlet UIImageView *cellAvatarImage;
@property IBOutlet NSLayoutConstraint *leftConstaint;
@property IBOutlet NSLayoutConstraint *rightConstaint;
@property (nonatomic, weak) IBOutlet UIView *cellView;


- (void)setupWithModel:(MessageEntity *)model;

- (void)loadWithFrame:(CGRect)rect;

- (void)initWithMessage:(MessageEntity *)message;

- (CGSize)heightForRowFromMessageObject:(MessageEntity *)messageObject;

- (void)cellFromMessage:(MessageObject *)messageObject;

//- (void)loadWithMessageObject:(User*)messageObject;

@end
