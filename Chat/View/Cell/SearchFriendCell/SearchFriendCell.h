//
//  SearchFriendCell.h
//  Chat
//
//  Created by Maks on 11/16/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundedUser.h"

@interface SearchFriendCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;

- (void)setupWithModel:(FoundedUser *)model;

@end
