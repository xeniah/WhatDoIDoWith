//
//  WDIDCategoriesTableViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDCategoriesTableViewController.h"
#import "WDIDProvidersTableViewController.h"
#import "JSONUtils.h"
#import "AppDelegate.h"
#import "WDIDCategory.h"
#import "WDIDClient.h"
#import "WDIDProvider.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WDIDCategoriesTableViewController ()
@property (nonatomic, strong) NSArray *wdidProviders;
@property (nonatomic, strong) NSArray *wdidCategories;
@property (nonatomic, strong) WDIDCategory *selectedCategory;
@end

@implementation WDIDCategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CategoryCell"];
   
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.wdidCategories = [delegate fetchMultiple:WDIDCATEGORY_TYPE withPredicate:nil withSort:sort];
    
    if (self.wdidCategories.count == 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WDIDClient sharedClient] getJson:@"https://data.kingcounty.gov/api/views/zqwi-c5q3/rows.json" parameters:nil success:^(id JSON) {
            
            [[JSONUtils sharedJSONUtils] processJSONProviders:JSON];
            self.wdidCategories = [delegate fetchMultiple:WDIDCATEGORY_TYPE withPredicate:nil withSort:sort];
            [self.tableView reloadData];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        } failureWithResponse:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.wdidCategories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    WDIDCategory *wdidCategory = (WDIDCategory *)self.wdidCategories[indexPath.row];
    self.selectedCategory = wdidCategory;
    cell.textLabel.text = wdidCategory.categoryName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.8];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeOut"];
    
    [self performSegueWithIdentifier:@"showProviders" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WDIDProvidersTableViewController *providerController = [segue destinationViewController];
    providerController.providers = [self.selectedCategory.providers allObjects];
}


@end
