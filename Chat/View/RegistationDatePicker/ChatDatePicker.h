//
//  RegistrationDatePicker.h
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatDatePickerDelegate;


@interface ChatDatePicker : UIView

@property (nonatomic, weak) id<ChatDatePickerDelegate>delegate;

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

- (instancetype)initOnView:(UIView *)view;

- (void)hideDatePicker;

@end

@protocol ChatDatePickerDelegate <NSObject>

@required

- (void)dateSelected: (NSDate *)date;

@end
