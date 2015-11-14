//
//  AlertFactory.h
//  Chat
//
//  Created by Maks on 11/4/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertFactory : UIAlertController

+ (UIAlertController*)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
