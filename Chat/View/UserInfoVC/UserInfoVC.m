//
//  UserInfoVCViewController.m
//  Chat
//
//  Created by Maks on 11/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserInfoVC.h"
#import "HTTPManager.h"
#import "MBProgressHUD.h"
#import "UserProfileEditVC.h"

@interface UserInfoVC ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UILabel *birthdayLabel;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HTTPManager sharedInstance]loadUserInfoCompliction:^(NSDictionary *dictionary){
        self.nameLabel.text = [dictionary valueForKey:@"username"];
        self.emailLabel.text = [dictionary valueForKey:@"email"];
        self.birthdayLabel.text = [dictionary valueForKey:@"birthday"];
    }
    failure:^(NSString *errorText){
        NSLog(@"%@", errorText);
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


@end
