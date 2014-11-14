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
#import "Constants.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WDIDCategoriesTableViewController ()
@property (nonatomic, strong) NSArray *wdidProviders;
@property (nonatomic, strong) NSArray *wdidCategories;
@property (nonatomic, strong) WDIDCategory *selectedCategory;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end

@implementation WDIDCategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Categories";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CategoryCell"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.wdidCategories = [delegate fetchMultiple:WDIDCATEGORY_TYPE withPredicate:nil sort:sort];
    
    if (self.wdidCategories.count == 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[WDIDClient sharedClient] getJson:DATA_URL parameters:nil success:^(id JSON) {
            
            [[JSONUtils sharedJSONUtils] processJSONProviders:JSON];
            self.wdidCategories = [delegate fetchMultiple:WDIDCATEGORY_TYPE withPredicate:nil sort:sort];
            [self.tableView reloadData];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self setupSearch];
            
        } failureWithResponse:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }else{
        [self setupSearch];
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

    if (tableView == ((UITableViewController *)self.searchController.searchResultsController).tableView) {
        return [self.searchResults count];
    } else {
        return self.wdidCategories.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    WDIDCategory *wdidCategory;
    
    if (tableView == ((UITableViewController *)self.searchController.searchResultsController).tableView) {
        wdidCategory = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        wdidCategory = (WDIDCategory *)self.wdidCategories[indexPath.row];
    }
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WDIDProvidersTableViewController *providerController = [segue destinationViewController];
    providerController.providers = [self.selectedCategory.providers allObjects];
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    [self updateFilteredContentForCategory:searchString];
    [((UITableViewController *)self.searchController.searchResultsController).tableView reloadData];
}


#pragma mark - Content Filtering
- (void)updateFilteredContentForCategory:(NSString *)categoryName {
    
    if ((categoryName == nil) || [categoryName length] == 0) {
        self.searchResults = [self.wdidCategories mutableCopy];
        return;
    }
    
    [self.searchResults removeAllObjects]; // First clear the filtered array.
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"categoryName contains[c] %@", categoryName];
    self.searchResults = [[self.wdidCategories filteredArrayUsingPredicate:resultPredicate] mutableCopy];
}


#pragma mark - Helpers & Utilities
- (void) setupSearch
{
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.wdidCategories count]];
    
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    [searchResultsController.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CategoryCell"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}




@end
