//
//  WDIDProvidersTableViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/8/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProvidersTableViewController.h"
#import "WDIDProviderDetailViewController.h"
#import "WDIDProvidersTableViewCell.h"
#import "WDIDMapViewController.h"
#import "WDIDProvider.h"

#define PROVIDER_CELL       @"WDIDProvidersTableViewCell"

@interface WDIDProvidersTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showMapButton;
@end

@implementation WDIDProvidersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Providers";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMapButtonClicked:)];
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // no need to register when using a prototype cell
  //  [self.tableView registerClass:[WDIDProvidersTableViewCell class] forCellReuseIdentifier:PROVIDER_CELL];
}

- (void)viewDidAppear:(BOOL)animated
{
     [self.tableView reloadData];
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
    WDIDProvidersTableViewCell *cell = (WDIDProvidersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PROVIDER_CELL forIndexPath:indexPath];
    WDIDProvider *provider = self.providers[indexPath.row];
    cell.providerNameLabel.text = provider.providerName;
    cell.additionalInfoLabel.text = provider.providerURL;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showProviderDetail"]) {
        WDIDProviderDetailViewController *detail = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        detail.provider = [self.providers objectAtIndex:indexPath.row];
    }
}

- (IBAction)showMapButtonClicked:(id)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WDIDMapViewController* mapController = [sb instantiateViewControllerWithIdentifier:@"WDIDMapViewController"];
    mapController.providers = self.providers;
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:@"SlideUp"];
    
    [self.navigationController pushViewController:mapController animated:YES];

}

@end
