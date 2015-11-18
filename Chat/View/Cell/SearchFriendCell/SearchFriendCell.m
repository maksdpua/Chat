//
//  SearchFriendCell.m
//  Chat
//
//  Created by Maks on 11/16/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "SearchFriendCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SearchFriendCell

- (void)setupWithModel:(User *)model {
    
    self.nameLabel.text=model.userName;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.avatar] ] placeholderImage:[UIImage placeholderImage]];
}



@end
