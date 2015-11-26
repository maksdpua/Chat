//
//  DialogCell.m
//  Chat
//
//  Created by Maks on 11/26/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogCell.h"

@interface DialogCell()

@property (nonatomic, weak) IBOutlet UIImageView *dialogImage;
@property (nonatomic, weak) IBOutlet UILabel *dialogUserNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dialogLabel;

@end

@implementation DialogCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithModel:(User *)model {
    self.dialogLabel.text = model.messageText;
    self.dialogUserNameLabel.text = model.userName;
    [self.dialogImage setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.avatar]] placeholderImage:[UIImage placeholderImage]];
}

- (CGFloat)loadWithHeight {
    return self.dialogImage.frame.size.height+10;
}



@end
