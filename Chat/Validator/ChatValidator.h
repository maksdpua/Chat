//
//  ChatValidator.h
//  Chat
//
//  Created by Maks on 10/31/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatValidator : NSObject

- (NSString *)isValidPassword:(NSString *)password;

- (NSString *)isValidEmail:(NSString *)email;

@end
