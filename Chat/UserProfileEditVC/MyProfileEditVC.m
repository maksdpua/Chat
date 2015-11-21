//
//  UserProfileEditVC.m
//  Chat
//
//  Created by Maks on 11/4/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MyProfileEditVC.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "UserInfo.h"

@interface MyProfileEditVC ()<ChatDatePickerDelegate, FamilyStatusPickerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ChatDatePicker *datePicker;
@property (nonatomic, strong) FamilyStatusPicker *familyStatusPicker;

@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;

@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *hometownTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *birthdayTextField;


@property (nonatomic, weak) IBOutlet UITextField *favoriteTextField;
@property (nonatomic, weak) IBOutlet UITextField *universityTextField;


@property (nonatomic, weak) IBOutlet UIButton *familyStatusButton;
@property (nonatomic, weak) IBOutlet UISwitch *genderSwitch;


@end

@implementation MyProfileEditVC {
    NSInteger unixTimeBirthday;
    NSNumber *selectedFamilyStatusID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseDataFromHTTPManager];
}


- (void)parseDataFromHTTPManager {
    
}


- (IBAction)saveChangesInUserProfile:(id)sender {
    
    NSNumber *genderIsMale = [NSNumber numberWithBool:self.genderSwitch.on] ;
    NSString *user_birthdayString = [NSString stringWithFormat:@"%tu", unixTimeBirthday];
    
    if ([self.userNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@""] || [self.phoneTextField.text isEqualToString:@""] || user_birthdayString==nil || selectedFamilyStatusID.stringValue==nil ||  [self.hometownTextField.text isEqualToString:@""]) {
        
        UIAlertController * alert = [AlertFactory showAlertWithTitle:@"Warning" message:@"Please enter all information!"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    else {
        NSDictionary *userProfile = @{@"user_name" : self.userNameTextField.text,
                                      @"user_lastname" : self.lastNameTextField.text,
                                      @"user_phone" : self.phoneTextField.text,
                                      @"user_gender" : genderIsMale.stringValue,
                                      @"user_birthday" : user_birthdayString,
                                      @"familystatus" : selectedFamilyStatusID.stringValue,
                                      @"user_work_place" : @"workplace",
                                      @"user_work_position" : @"workposition",
                                      @"user_about_me" : @"something",
                                      @"user_favourite" : @"favorite",
                                      @"user_university" : self.universityTextField.text,
                                      @"user_school" : @"55",
                                      @"user_hometown" : self.hometownTextField.text};
        [[APIRequestManager sharedInstance]POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@",kURLServer, kMyProfile] parameters:userProfile classMapping:[UserInfo class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }fail:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error - %@",error);
        }];
    }
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

- (IBAction)selectFamilyStatusButton:(id)sender {
    self.familyStatusPicker = [[FamilyStatusPicker alloc]initOnView:self.navigationController.view];
    self.familyStatusPicker.delegate = self;
}

- (void)dateSelected:(NSDate *)date {
    unixTimeBirthday = [date timeIntervalSince1970];
    
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    self.birthdayTextField.text = stringFromDate;
}

- (void)familyStatusSelectedID:(NSNumber *)familyStatusID {
    selectedFamilyStatusID = familyStatusID;
}

- (void)familyStatusSelectedInString:(NSString *)familyStatusString {
    self.familyStatusButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.familyStatusButton.titleLabel.text = familyStatusString;
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
