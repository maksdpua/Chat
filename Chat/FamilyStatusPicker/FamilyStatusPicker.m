//
//  FamilyStatusPicker.m
//  Chat
//
//  Created by Maks on 11/5/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "FamilyStatusPicker.h"

@interface FamilyStatusPicker()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *statuses;
@property (nonatomic, strong) NSNumber *statusID;
@property (nonatomic, strong) NSString *statusString;

@end

@implementation FamilyStatusPicker


- (instancetype)initOnView:(UIView *)view {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
    if (self) {
        self.statuses = @[@"Single", @"In a relationship", @"Engaged", @"Married", @"In love", @"It's complicated", @"Activelly searching"];
        self.alpha = 0;
        
        self.statusString = [self.statuses objectAtIndex:0];
        self.statusID = [NSNumber numberWithInteger:8];
        
        [view addSubview:self];
        [self showWithDuration:0.25 withAlpha:1];
    }
    return self;
}

- (void)showWithDuration:(CGFloat)duration withAlpha:(CGFloat)alpha {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = alpha;
    }];
}

- (IBAction)cancelButton:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)okButton:(id)sender {
    if (self.delegate) {
        
        [self.delegate familyStatusSelectedID:self.statusID];
        [self.delegate familyStatusSelectedInString:self.statusString];
        
        [self cancelButton:nil];
    } else {
        [self cancelButton:nil];
    }
}

- (void)hideDatePicker {
    [self cancelButton:nil];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    self.statusString = [self.statuses objectAtIndex:row];
    
    if (row == -1) {
        self.statusString = [self.statuses objectAtIndex:0];
        self.statusID = [NSNumber numberWithInteger:8];
    }
    
    switch (row) {
        case 0:
            self.statusID = [NSNumber numberWithInteger:8];
            break;
        case 1:
            self.statusID = [NSNumber numberWithInteger:9];
            break;
        case 2:
            self.statusID = [NSNumber numberWithInteger:10];
            break;
        case 3:
            self.statusID = [NSNumber numberWithInteger:11];
            break;
        case 4:
            self.statusID = [NSNumber numberWithInteger:12];
            break;
        case 5:
            self.statusID = [NSNumber numberWithInteger:13];
            break;
        case 6:
            self.statusID = [NSNumber numberWithInteger:14];
        default:
            NSLog(@"Wrong row");
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.statuses.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.statuses objectAtIndex:row];
}


@end
