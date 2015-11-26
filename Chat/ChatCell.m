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

@implementation ChatCell
{
    NSInteger labelTextWidth;
}

- (void)loadWithFrame:(CGRect)rect {
    labelTextWidth = rect.size.width - leftX * 2;
}

- (void)initWithMessage:(User *)message {
    self.labelCell.text = message.messageText;
}

- (CGSize)heightForRowFromMessageObject:(MessageObject *)messageObject {
    
    NSString *text = (messageObject.messageText && messageObject.messageText.length > 0) ? messageObject.messageText : @" ";
    NSDictionary *attributes = @{NSFontAttributeName: self.labelCell.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelTextWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (void)cellFromMessage:(User *)messageObject {
    
}

- (void)loadWithMessageObject:(User *)messageObject {
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
    
    if (messageObject.userID==[AuthorizeManager userID]) {
        self.leftConstaint.constant = leftX;
        self.rightConstaint.constant = labelTextWidth + leftX - width;
        self.labelCell.backgroundColor = [UIColor yellowColor];
    } else {
        self.leftConstaint.constant = labelTextWidth + leftX - width;
        self.rightConstaint.constant = leftX;
        self.labelCell.backgroundColor = [UIColor greenColor];
    }
    [self layoutIfNeeded];
}


@end
