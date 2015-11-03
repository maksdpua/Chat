//
//  RegistrationVC.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "RegistrationVC.h"
#import "ChatAPI.h"

@interface RegistrationVC()<ChatDatePickerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) ChatDatePicker *datePicker;
@property (nonatomic, strong) ChatAPI *loader;

@end

@implementation RegistrationVC
{
    NSInteger unixTimeBirthday;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loader = [[ChatAPI alloc]init];
}

- (IBAction)registrateUserAction:(id)sender {
    [self.loader registrateUserWithNameString:self.nameTextField.text emailString:self.emailTextField.text date:unixTimeBirthday passwordString:self.passwordTextField.text];
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


@end
