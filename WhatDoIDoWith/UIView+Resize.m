//
//  UIView+Resize.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/10/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "UIView+Resize.h"

@implementation UIView (Resize)

- (void)resizeToFitSubviews
{
    float w = 0;
    float h = 0;
    for (UIView *v in self.subviews) {
        float fw = v.frame.origin.x + v.frame.size.width;
        w = MAX(fw, w);
        h += v.frame.size.height + 5;
        NSLog(@"%f", v.frame.size.height);
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h)];
}

@end
