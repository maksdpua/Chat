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

- (void)setupWithModel:(FoundedUser *)model {
    
    self.nameLabel.text=model.userName;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.avatar] ] placeholderImage:[UIImage placeholderImage]];
}

- (NSString *)checkForImageAvatarPath:(NSString *)path {
    if ([path hasPrefix:@"http://dev."]) {
        return path;
    } else {
        NSRange range = [path rangeOfString:@"http://"];
        if (range.location != NSNotFound) {
            path = [NSString stringWithFormat:@"http://dev.%@", [path substringFromIndex:range.length]];
        }
        return path;
    }
}

@end
