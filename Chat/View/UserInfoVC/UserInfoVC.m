//
//  UserInfoVCViewController.m
//  Chat
//
//  Created by Maks on 11/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserInfoVC.h"
#import "HTTPManager.h"
#import "APIRequestManager.h"
#import "MBProgressHUD.h"
#import "UserProfileEditVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserInfoVC ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataInVC];
}

- (void) loadDataInVC {
    
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
    if ([[HTTPManager sharedInstance] isNetworkReachable]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        UserProfileEditVC *userProfileEditVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserProfileEditVC class])];
        
        [self.navigationController pushViewController:userProfileEditVC animated:YES];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else {
        UIAlertController * alert = [AlertFactory showAlertWithTitle:@"error" message:@"Network is not reachable"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    
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
