//
//  DialogCell.h
//  Chat
//
//  Created by Maks on 11/26/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DialogCell : UITableViewCell

- (void)setupWithModel:(User *)model;

- (CGFloat)loadWithHeight;

@end
