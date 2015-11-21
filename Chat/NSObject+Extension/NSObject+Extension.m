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
            if ([[obj class] isSubclassOfClass:[NSNull class]]) {
                [self setValue:nil forKey:propertyName];
            }
            if ([[obj class] isSubclassOfClass:[NSNumber class]]) {
                [self setValue:[NSString stringWithFormat:@"%@", obj] forKey:propertyName];
            } else if([[obj class] isSubclassOfClass:[NSString class]]) {
                [self setValue:obj forKey:propertyName];
            }
            
        }
    }];
    return self;
}

- (void)printDescription {
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:propertyName];
        if (value)
            propertyValues[propertyName] = value;
        else
            propertyValues[propertyName] = @"nil";
    }
    free(properties);
    NSLog(@"%@", [NSString stringWithFormat:@"\n%@:\n%@", self.class, propertyValues]);
}

- (NSString *)checkForImageAvatarPath:(NSString *)path {
    if ([path hasPrefix:@"http://dev."]) {
        return path;
    } else {
        NSRange range = [path rangeOfString:@"http://"];
        if (range.location != NSNotFound) {
            path = [NSString stringWithFormat:@"http://dev.%@", [path substringFromIndex:range.length]];
        }
        return path;
    }
}


@end
