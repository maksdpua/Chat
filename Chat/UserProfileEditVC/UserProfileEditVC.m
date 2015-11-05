//
//  UserProfileEditVC.m
//  Chat
//
//  Created by Maks on 11/4/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserProfileEditVC.h"
#import "HTTPManager.h"

@interface UserProfileEditVC ()<ChatDatePickerDelegate, FamilyStatusPickerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ChatDatePicker *datePicker;
@property (nonatomic, strong) FamilyStatusPicker *familyStatusPicker;

@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *hometownTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, weak) IBOutlet UIButton *familyStatusButton;
@property (nonatomic, weak) IBOutlet UISwitch *genderSwitch;


@end

@implementation UserProfileEditVC {
    NSInteger unixTimeBirthday;
    NSNumber *selectedFamilyStatusID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseDataFromHTTPManager];
}


- (void)parseDataFromHTTPManager {
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
        
        NSString *user_birthdayString = [NSString stringWithFormat:@"%tu", unixTimeBirthday];
        
        NSDictionary *userProfile = @{@"user_name" : self.userNameTextField.text,
                                 @"user_lastname" : self.lastNameTextField.text,
                                      @"user_phone" : self.phoneTextField.text,
                                      @"user_gender" : self.genderSwitch,
                                      @"user_birthday" : user_birthdayString,
                                      @"familystatus" : selectedFamilyStatusID.stringValue,
                                      @"user_avatar" : [UIImage placeholderImage]};
        
        [[HTTPManager sharedInstance]editUserProfileWithDictionary:userProfile];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //        UserProfileEditVC *userProfileEditVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserProfileEditVC class])];
        //
        //        [self.navigationController pushViewController:userProfileEditVC animated:YES];
    } else {
        UIAlertController * alert = [AlertFactory showAlertWithTitle:@"error" message:@"Network is not reachable"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
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
    self.familyStatusPicker = [[FamilyStatusPicker alloc]initOnView:self.view];
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
