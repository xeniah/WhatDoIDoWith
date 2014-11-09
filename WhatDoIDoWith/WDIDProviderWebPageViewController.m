//
//  WDIDProviderWebPageViewController.m
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProviderWebPageViewController.h"

@interface WDIDProviderWebPageViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WDIDProviderWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
}

- (void)viewDidLayoutSubviews
{
    NSURL* nsUrl = [NSURL URLWithString:self.pageURLStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id)initWithURLStr:(NSString *)urlStr
{
    if(self = [super init])
    {
        self.pageURLStr = urlStr;
    }
    return self;
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    NSString *yourHTMLSourceCodeString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    
    NSLog(@"%@",yourHTMLSourceCodeString);
}


@end
