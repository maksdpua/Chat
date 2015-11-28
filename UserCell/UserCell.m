//
//  UserCell.m
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserCell.h"
#import "User.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"

static int kCornerRadius = 10;

@implementation UserCell



- (void)setupWithModel:(User *)model {
    self.avatarImage.layer.cornerRadius = kCornerRadius;
    self.nameLabel.text=model.userName;
    [self.avatarImage setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userThumbnailAvatar]] placeholderImage:[UIImage placeholderImage]];
}

- (CGFloat)loadWithHeight {
    return self.avatarImage.frame.size.height+10;
}



@end
