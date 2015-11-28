//
//  SearchFriendCell.m
//  Chat
//
//  Created by Maks on 11/16/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "SearchFriendCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

static int kCornerRadius = 10;

@implementation SearchFriendCell

- (void)setupWithModel:(User *)model {
    self.avatarImage.layer.cornerRadius = kCornerRadius;
    self.nameLabel.text=model.userName;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userThumbnailAvatar] ] placeholderImage:[UIImage placeholderImage]];
}

- (CGFloat)loadWithHeight {
    return self.avatarImage.frame.size.height+10;
}



@end
