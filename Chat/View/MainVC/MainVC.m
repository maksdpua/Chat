//
//  MainVC.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MainVC.h"
#import "HTTPManager.h"
#import "UserInfoVC.h"
#import "RegistrationVC.h"
#import "MBProgressHUD.h"


@interface MainVC()

@property (nonatomic, strong)IBOutlet UITextField *emailTextField;
@property (nonatomic, strong)IBOutlet UITextField *passwordTextField;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"user_email"]) {
        self.emailTextField.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_email"];
    }
    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"user_password"]) {
        self.passwordTextField.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_password"];
    }
}

- (IBAction)loginAction:(id)sender {
    if ([[HTTPManager sharedInstance] isNetworkReachable]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        ChatValidator *validation = [[ChatValidator alloc]init];
        if ([validation isValidEmail:self.emailTextField.text]) {
            NSLog(@"%@",[validation isValidEmail:self.emailTextField.text]);
        }
        [[HTTPManager sharedInstance] loginUserWithEmailString:self.emailTextField.text passwordString:self.passwordTextField.text compliction:^{
            
            UserInfoVC *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserInfoVC class])];
            
            [self.navigationController pushViewController:userInfoVC animated:YES];
            
        }failure:^(NSString *errorText) {
            NSLog(@"%@", errorText);
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } else {
        UIAlertController * alert = [AlertFactory showAlertWithTitle:@"error" message:@"Network is not reachable"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)registrationAction:(id)sender {
    RegistrationVC *registrationVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RegistrationVC class])];
    [self.navigationController pushViewController:registrationVC animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

@end
