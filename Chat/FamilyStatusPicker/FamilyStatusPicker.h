//
//  FamilyStatusPicker.h
//  Chat
//
//  Created by Maks on 11/5/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FamilyStatusPickerDelegate;

@interface FamilyStatusPicker : UIView


@property (nonatomic, weak) id<FamilyStatusPickerDelegate>delegate;

@property (nonatomic, weak) IBOutlet UIPickerView *familyStatusPicker;

- (instancetype)initOnView:(UIView *)view;

- (void)hideDatePicker;

@end

@protocol FamilyStatusPickerDelegate <NSObject>

@required

- (void)familyStatusSelectedID:(NSNumber *)familyStatusID;
- (void)familyStatusSelectedInString:(NSString *)familyStatusString;

@end
