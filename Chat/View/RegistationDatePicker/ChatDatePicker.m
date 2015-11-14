//
//  RegistrationDatePicker.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ChatDatePicker.h"

@implementation ChatDatePicker 

- (instancetype)initOnView:(UIView *)view {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
    if (self) {
        
        self.alpha = 0;
        
        self.frame = view.frame;
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
        [self.delegate dateSelected:self.datePicker.date];
        [self cancelButton:nil];
    } else {
        [self cancelButton:nil];
    }
}

- (void)hideDatePicker {
    [self cancelButton:nil];
}

@end
