//
//  NSObject+Extension.m
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary InstructionDictionary:(NSDictionary *)instruction {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyName = [instruction valueForKey:key];
        if (propertyName) {
            if ([[obj class] isSubclassOfClass:[NSNumber class]]) {
                [self setValue:[NSString stringWithFormat:@"%@", obj] forKey:propertyName];
            } else {
                [self setValue:obj forKey:propertyName];
            }
        }
    }];
    return self;
}

@end
