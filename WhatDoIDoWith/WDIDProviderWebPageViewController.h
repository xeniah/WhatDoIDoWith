//
//  WDIDProviderWebPageViewController.h
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDIDProviderWebPageViewController : UIViewController<UIWebViewDelegate>
@property   (nonatomic, strong) NSString *pageURLStr;
- (id)initWithURLStr:(NSString *)urlStr;
@end
