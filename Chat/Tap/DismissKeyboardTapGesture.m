//
//  DismissKeyboardTapGesture.m
//  Chat
//
//  Created by Maks on 12/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DismissKeyboardTapGesture.h"

@interface DismissKeyboardTapGesture()<UIGestureRecognizerDelegate>



@end

@implementation DismissKeyboardTapGesture

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
//        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
//        swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
//        [view addGestureRecognizer:swipeGesture];
//        
//        
//        UISwipeGestureRecognizer *swipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
//        swipeGesture2.direction = UISwipeGestureRecognizerDirectionDown;
//        [view addGestureRecognizer:swipeGesture2];
            }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // Don't stop any existing gestures in our view from working
    if (otherGestureRecognizer.view == gestureRecognizer.view) {
        return YES;
    }
    return NO;
}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer
{
    // Close keyboard for any text edit views that are children of the main view
    [gestureRecognizer.view endEditing:YES];
}

//-(void)handleSwipeGesture:(UISwipeGestureRecognizer *) sender
//{
//    
//    //Gesture detect - swipe up/down , can be recognized direction
//    if(sender.direction == UISwipeGestureRecognizerDirectionUp)
//    {
//        
//        [tf becomeFirstResponder];
//        
//        NSLog(@"Up");
//        
//    }
//    else if(sender.direction == UISwipeGestureRecognizerDirectionDown)
//    {
//        
//        [tf resignFirstResponder];
//        NSLog(@"down");
//    }

@end
