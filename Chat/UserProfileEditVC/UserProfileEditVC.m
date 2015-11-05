//
//  UserProfileEditVC.m
//  Chat
//
//  Created by Maks on 11/4/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserProfileEditVC.h"
#import "HTTPManager.h"

@interface UserProfileEditVC ()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *hometownTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, weak) IBOutlet UITextField *familyStatusTextField;
@property (nonatomic, weak) IBOutlet UISwitch *genderSwitch;

@end

@implementation UserProfileEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseDataWithHTTPManager];
}


- (void)parseDataWithHTTPManager {
    [[HTTPManager sharedInstance]loadUserInfoCompliction:^(NSDictionary *dictionary){
        self.userNameTextField.text = [dictionary valueForKey:@"username"];
        self.emailTextField.text = [dictionary valueForKey:@"email"];
        self.birthdayTextField.text = [dictionary valueForKey:@"birthday"];
    }
    failure:^(NSString *errorText){
        NSLog(@"%@", errorText);
        }];
}

- (IBAction)saveChangesInUserProfile:(id)sender {
    if ([[HTTPManager sharedInstance] isNetworkReachable]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSDictionary *userProfile = @{@"username" : self.userNameTextField.text,
                                 @"lastname" : self.lastNameTextField.text};
        [[HTTPManager sharedInstance]editUserProfileWithDictionary:userProfile];
//        UserProfileEditVC *userProfileEditVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserProfileEditVC class])];
//        
//        [self.navigationController pushViewController:userProfileEditVC animated:YES];
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else {
        UIAlertController * alert = [AlertFactory showAlertWithTitle:@"error" message:@"Network is not reachable"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }

}
@end
