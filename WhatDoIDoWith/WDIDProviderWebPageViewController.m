//
//  WDIDProviderWebPageViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProviderWebPageViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WDIDProviderWebPageViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WDIDProviderWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSURL* nsUrl = [NSURL URLWithString:self.pageURLStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
    //TODO
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Webpage could not be loaded" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


@end
