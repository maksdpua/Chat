//
//  ChatAPI.h
//  Chat
//
//  Created by Maks on 11/2/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatAPI : NSObject

+ (id)sharedInstance;

- (void)registrateUserWithNameString:(NSString*)name emailString:(NSString *)email date:(NSInteger)date passwordString:(NSString *)password;

- (void)loginUserWithEmailString:(NSString *)email passwordString:(NSString *)password;

- (void)loadUserInfo;

@end
