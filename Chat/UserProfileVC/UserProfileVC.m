//
//  UserProfileVC.m
//  Chat
//
//  Created by Maks on 11/17/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserProfileVC.h"
#import "ConstantsOfAPI.h"
#import "APIRequestManager.h"
#import "UserProfile.h"

@interface UserProfileVC()

@property (nonatomic, weak) IBOutlet UIImageView *userAvatar;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, strong) IBOutlet UIButton *addToFriendButton;

@end

@implementation UserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserProfileWithFoundedUser];
}

- (void)getUserProfileWithFoundedUser {
    
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kUserProfile, self.userData.userID] classMapping:[UserProfile class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject){
        [responseObject printDescription];
        [self fillUserProfileWithResponse:(UserProfile *)responseObject];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)fillUserProfileWithResponse:(UserProfile *)model {
    self.nameLabel.text = model.userName;
    self.lastNameLabel.text = model.userLastName;
    [self.userAvatar setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userAvatar]] placeholderImage:[UIImage placeholderImage]];
    if (!model.isFriend) {
        [self.addToFriendButton setEnabled:NO];
    }
    
}

- (IBAction)addToFriendAction:(id)sender {
    [[APIRequestManager sharedInstance] PUTConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kAddUserToFriends, self.userData.userID] classMapping:nil requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}






@end
