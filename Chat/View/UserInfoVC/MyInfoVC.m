//
//  UserInfoVCViewController.m
//  Chat
//
//  Created by Maks on 11/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MyInfoVC.h"
#import "UserProfile.h"
#import "APIRequestManager.h"
#import "MyProfileEditVC.h"
#import "ConstantsOfAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AuthorizeManager.h"
#import "MainNavigation.h"
#import "MainVC.h"

@interface MyInfoVC ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataInVC];
}

- (void) loadDataInVC {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kMyProfile] classMapping:[UserProfile class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject printDescription];
        UserProfile *model = (UserProfile *)responseObject;
        self.nameLabel.text = model.userName;
        self.emailLabel.text = model.userEmail;
        self.birthdayLabel.text = model.userBirthday;
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userAvatar]] placeholderImage:[UIImage placeholderImage]];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)pushToEditVC:(id)sender {
    MyProfileEditVC *editVC = [self.storyboard instantiateViewControllerWithIdentifier:kMyProfileEditVC];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (IBAction)logoutAction:(id)sender {
    [self requestToLogout];
    [AuthorizeManager removeUserIdAndSessionHashData];

}

- (void)requestToLogout {
    [[APIRequestManager sharedInstance] PUTConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kLogout] classMapping:nil requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


@end
