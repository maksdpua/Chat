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
#import "HTTPManager.h"

@interface MyProfileEditVC ()<ChatDatePickerDelegate, FamilyStatusPickerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) ChatDatePicker *datePicker;
@property (nonatomic, strong) FamilyStatusPicker *familyStatusPicker;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

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
    [self parseDataFromResponse];
    self.familyStatusButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)parseDataFromResponse {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kMyProfile] classMapping:[UserInfo class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject){
        [self responseWithModel:(UserInfo *)responseObject];
        
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error - %@", error);
         }];
}

- (void)responseWithModel:(UserInfo *)model {
    [self.avatarImage setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:model.userAvatar]] placeholderImage:[UIImage placeholderImage]];
    self.userNameTextField.text = model.userName;
    self.lastNameTextField.text = model.userLastname;
    self.birthdayTextField.text = model.userBirthday;
    self.emailTextField.text = model.userEmail;
    self.phoneTextField.text = model.userPhone;
    self.hometownTextField.text = model.userHometown;
    self.favoriteTextField.text = model.userFavourite;
    self.universityTextField.text = model.userUnivercity;
    self.genderSwitch.on = model.isMale.boolValue;
}

- (IBAction)changeAvatar:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
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
                                      @"user_favourite" : self.favoriteTextField.text,
                                      @"user_university" : self.universityTextField.text,
                                      @"user_school" : @"55",
                                      @"user_hometown" : self.hometownTextField.text};

        [[APIRequestManager sharedInstance]POSTConnectionWithURLStringAndData:[NSString stringWithFormat:@"%@%@",kURLServer, kMyProfile] parameters:userProfile image:self.avatarImage.image classMapping:nil requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"%@", responseObject);
        }fail:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"%@", error);
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
    self.familyStatusButton.titleLabel.text = self.familyStatusPicker.statusString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.avatarImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
