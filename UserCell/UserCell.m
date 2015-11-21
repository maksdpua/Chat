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

@implementation UserCell

- (void)setupWithModel:(User *)model {
    self.nameLabel.text=model.userName;
    [self.avatarImage setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.avatar]] placeholderImage:[UIImage placeholderImage]];
}



@end
