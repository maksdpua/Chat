//
//  RegistrationVC.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "RegistrationVC.h"
#import "HTTPManager.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"

@interface RegistrationVC()<ChatDatePickerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) ChatDatePicker *datePicker;

@end

@implementation RegistrationVC
{
    NSInteger unixTimeBirthday;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)registrateUserAction:(id)sender {
    NSString *language = @"1";
    NSString *user_token = kToken;
    NSString *user_birthday = [NSString stringWithFormat:@"%tu", unixTimeBirthday];
    NSDictionary *params = @{@"user_name" : name,
                             @"user_email" : self.emailTextField.text,
                             @"user_password" : self.passwordTextField.text,
                             @"user_token" : user_token,
                             @"user_birthday": user_birthday,
                             @"language" : language};
    [[APIRequestManager sharedInstance]POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kRegistrationPath] parameters:params classMapping:nil requestSerializer:NO showProgressOnView:self.view response: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadDatePicker {
    self.datePicker = [[ChatDatePicker alloc]initOnView:self.view];
    self.datePicker.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.birthdayTextField]) {
        [self.view endEditing:YES];
        [self loadDatePicker];
        return NO;
    } else {
        [self.datePicker hideDatePicker];
        return YES;
    }
}

- (void)dateSelected:(NSDate *)date {
    unixTimeBirthday = [date timeIntervalSince1970];
    
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    self.birthdayTextField.text = stringFromDate;
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}

@end
