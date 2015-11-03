//
//  MainVC.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MainVC.h"
#import "ChatAPI.h"
@interface MainVC()

@property (nonatomic, strong)IBOutlet UITextField *emailTextField;
@property (nonatomic, strong)IBOutlet UITextField *passwordTextField;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginAction:(id)sender {
    [[ChatAPI sharedInstance] loginUserWithEmailString:self.emailTextField.text passwordString:self.passwordTextField.text];
}

@end
