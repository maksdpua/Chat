//
//  ChatValidator.m
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ChatValidator.h"

@implementation ChatValidator

- (NSString *)isValidPassword:(NSString *)password {
    if (password.length > 20 || password.length < 6)
        return @"Пароль должен быть не меньше 6 и не больше 20 символов";
    return nil;
}

- (NSString *)isValidEmail:(NSString *)email {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email] ? nil : @"email введен некорректно";
}


@end
