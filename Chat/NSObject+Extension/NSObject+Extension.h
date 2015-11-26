//
//  NSObject+Extension.h
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FillingClassProtocol

@optional

- (instancetype) initClassWithDictionary: (NSDictionary *)dictionary;

@end

@interface NSObject (Extension) <FillingClassProtocol>

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary InstructionDictionary:(NSDictionary *)instruction;

- (void)printDescription;

- (NSString *)checkForImageAvatarPath:(NSString *)path;

- (BOOL)checkForSymbolsInString:(NSString *)string;

@end
