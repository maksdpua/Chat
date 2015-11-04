//
//  AlertFactory.m
//  Chat
//
//  Created by Maks on 11/4/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "AlertFactory.h"

@implementation AlertFactory

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"OK", nil)]
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    return alert;
}


@end
