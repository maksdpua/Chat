//
//  NSObject+Extension.h
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary InstructionDictionary:(NSDictionary *)instruction;

@end
