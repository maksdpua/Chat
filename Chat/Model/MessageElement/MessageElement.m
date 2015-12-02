//
//  MessageElement.m
//  Chat
//
//  Created by Maks on 12/1/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MessageElement.h"

@implementation MessageElement

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetRGBFillColor(context, 0, 0, 255, 1);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, 10, 10));
}

@end
