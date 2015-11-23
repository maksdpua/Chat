//
//  UIButton+indexPath.m
//  Chat
//
//  Created by Maks on 11/21/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UIButton+indexPath.h"
#import <objc/runtime.h>

@implementation UIButton (indexPath)

static char UIB_PROPERTY_KEY;

@dynamic indexPathForButton;

- (void)setIndexPathForButton:(NSIndexPath *)indexPathForButton {
    objc_setAssociatedObject(self, &UIB_PROPERTY_KEY, indexPathForButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexPathForButton {
    return (NSIndexPath *)objc_getAssociatedObject(self, &UIB_PROPERTY_KEY);
}


@end
