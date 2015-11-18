//
//  UserInfoVCViewController.m
//  Chat
//
//  Created by Maks on 11/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MyInfoVC.h"
#import "MyProfile.h"
#import "HTTPManager.h"
#import "APIRequestManager.h"
#import "MBProgressHUD.h"
#import "MyProfileEditVC.h"
#import "ConstantsOfAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kMyProfile] classMapping:[MyProfile class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.nameLabel.text = [responseObject valueForKey:@"userName"];
        self.emailLabel.text = [responseObject valueForKey:@"userEmail"];
        self.birthdayLabel.text = [responseObject valueForKey:@"userBirthday"];
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:[responseObject valueForKey:@"userAvatar"] ]] placeholderImage:[UIImage placeholderImage]];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    if ([touch.view class]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)pushToEditVC:(id)sender {
        
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
