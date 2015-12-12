//
//  ChatCell.m
//  Chat
//
//  Created by Maks on 10/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ChatCell.h"
#import "Constants.h"
#import "AuthorizeManager.h"
#import "MessageElement.h"

@implementation ChatCell
{
    NSInteger labelTextWidth;
}

- (void)awakeFromNib {
    self.cellAvatarImage.layer.masksToBounds = YES;
    self.cellAvatarImage.layer.cornerRadius = 8;
    self.cellView.layer.masksToBounds = YES;
    self.cellView.layer.cornerRadius = 8;
}

- (void)setupWithModel:(MessageEntity *)model {
    self.labelCell.text = model.messageText;
    [self.cellAvatarImage setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userThumbnailAvatar]] placeholderImage:[UIImage placeholderImage]];
}

- (void)loadWithFrame:(CGRect)rect {
    labelTextWidth = rect.size.width - 112;
}

- (void)initWithMessage:(MessageEntity *)message {
    self.labelCell.text = message.messageText;
}

- (CGSize)heightForRowFromMessageObject:(MessageEntity *)messageObject {
    NSString *text = (messageObject.messageText && messageObject.messageText.length > 0) ? messageObject.messageText : @" ";
    NSDictionary *attributes = @{NSFontAttributeName: self.labelCell.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelTextWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (void)cellFromMessage:(MessageEntity *)messageObject {
    
}

- (void)loadWithMessageObject:(MessageEntity *)messageObject {
    self.labelCell.layer.cornerRadius = 5;
    self.labelCell.text = messageObject.messageText;
//    BOOL user = messageObject.userID.integerValue == user_id.integerValue ? YES : NO;
    CGSize size = [self heightForRowFromMessageObject:messageObject];
    NSInteger width = lround(size.width + 0.5);
    [self setNeedsUpdateConstraints];
    if (size.height>25) {
        self.leftConstaint.constant = leftX;
        self.labelCell.textAlignment = NSTextAlignmentLeft;
    } else {
        self.labelCell.textAlignment = NSTextAlignmentCenter;
    }
    
    if ([messageObject.userID isEqualToString:[AuthorizeManager userID]]) {
        self.leftConstaint.constant = leftX;
        self.rightConstaint.constant = labelTextWidth + leftX - width;
        self.labelCell.backgroundColor = [UIColor blueColor];
    } else {
        self.leftConstaint.constant = labelTextWidth + leftX - width;
        self.rightConstaint.constant = leftX;
        self.labelCell.backgroundColor = [UIColor greenColor];
    }
    [self layoutIfNeeded];
}


@end
