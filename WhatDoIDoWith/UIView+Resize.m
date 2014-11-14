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
        float fh = v.frame.origin.y + v.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h)];
}

@end
