//
//  UserCell.h
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UIButton+indexPath.h"

@interface UserCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, strong) IBOutlet UIButton *acceptButton;

- (void)setupWithModel:(User *)model;

- (CGFloat)loadWithHeight;

@end
