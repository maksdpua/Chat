//
//  MainVC.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MainVC.h"
#import "AuthorizeManager.h"
#import "APIRequestManager.h"
#import "UserInfoVC.h"
#import "RegistrationVC.h"
#import "MenuVC.h"
#import "ConstantsOfAPI.h"


@interface MainVC()

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginAction:(id)sender {
    if ([[APIRequestManager sharedInstance] isNetworkReachable]) {
        
        [self login];
        
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

- (void)login {
    NSString *user_token = kToken;
    NSDictionary *params = @{@"user_email" : self.emailTextField.text,
                             @"user_password" : self.passwordTextField.text,
                             @"user_token" : user_token};
    
    [[APIRequestManager sharedInstance] POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kLogin] parameters:params classMapping:[AuthorizeManager class] requestSerializer:NO showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        MenuVC *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MenuVC class])];
        [self.navigationController pushViewController:menuVC animated:YES];
    }fail:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@", operation.responseString);
    }];
    
}

@end
