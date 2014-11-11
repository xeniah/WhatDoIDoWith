//
//  WDIDProvidersTableViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/8/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProvidersTableViewController.h"
#import "WDIDProviderDetailViewController.h"
#import "WDIDProvider.h"
@interface WDIDProvidersTableViewController ()
@property (nonatomic, strong) WDIDProvider *selectedProvider;
@end

@implementation WDIDProvidersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Providers";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"providerCell"]; //TODO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.providers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"providerCell" forIndexPath:indexPath]; //TODO
    WDIDProvider *provider = self.providers[indexPath.row];
    cell.textLabel.text = provider.providerName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedProvider = self.providers[indexPath.row];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WDIDProviderDetailViewController* detail = [sb instantiateViewControllerWithIdentifier:@"WDIDProviderDetailViewController"];
    detail.provider = self.selectedProvider;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
