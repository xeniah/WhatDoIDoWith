//
//  WDIDProviderDetailViewController.m
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProviderDetailViewController.h"
#import "WDIDProviderDetailTableViewCell.h"
#import "WDIDProviderWebPageViewController.h"
#import "UIView+Resize.h"

@interface WDIDProviderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;
@property (nonatomic, strong) NSArray *providerDetailTitles;
@property (weak, nonatomic) IBOutlet UILabel *providerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *providerServiceDescriptionLabel;

@end


#define HOURS_INDEX             0
#define ADDRESS_INDEX           1
#define CITY_INDEX              2
#define ZIPCODE_INDEX           3
#define DESCRIPTION_INDEX       4
#define RESTRICTIONS_INDEX      5
#define FEE_INDEX               6
#define VIEW_ON_MAP_INDEX       7
#define WEBPAGE_INDEX           8


@implementation WDIDProviderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.provider.providerName;
    self.providerDetailTitles = @[@"Hours", @"Address", @"City", @"Zipcode", @"Description", @"Restrictions", @"Fee", @"View On Map", @"Go to Webpage"];
    self.providerNameLabel.text = self.provider.providerName;
    self.providerServiceDescriptionLabel.text = self.provider.providerServiceDescription;
   
    [UIView animateWithDuration:0.35 animations:^{
         [self.providerServiceDescriptionLabel sizeToFit];
         [self.tableViewHeader resizeToFitSubviews];
     }];
    self.tableView.tableHeaderView = self.tableViewHeader;
   
   // [self.tableView registerClass:[ProviderDetailTableViewCell class] forCellReuseIdentifier:@"providerDetailCell"]; // TODO
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

    return self.providerDetailTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDIDProviderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"providerDetailCell" forIndexPath:indexPath];
    
    //cell.textLabel.text = self.providerDetailTitles[indexPath.row];
    cell.titleLabel.text = self.providerDetailTitles[indexPath.row];
    NSString *infoText;
   
    switch (indexPath.row) {
            case HOURS_INDEX:
            infoText = self.provider.providerHours;
            break;
            case ADDRESS_INDEX:
            infoText = self.provider.providerAddress;
            break;
            case CITY_INDEX:
            infoText = self.provider.providerCity;
            break;
            case ZIPCODE_INDEX:
            infoText = self.provider.providerZip;
            break;
            case DESCRIPTION_INDEX:
            infoText = self.provider.providerHours;
            break;
            case RESTRICTIONS_INDEX:
            infoText = self.provider.providerRestrictions;
            break;
            case FEE_INDEX:
            infoText = self.provider.providerFee;
            break;
      
        default:
            infoText = @"";
            break;
    }
    cell.infoLabel.text = infoText;

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 8 && self.provider.providerURL!= nil && self.provider.providerURL.length > 0) // TODO
    {
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WDIDProviderWebPageViewController* webPageController = [sb instantiateViewControllerWithIdentifier:@"WDIDProviderWebPageViewController"];
        webPageController.pageURLStr = self.provider.providerURL;
        [self.navigationController pushViewController:webPageController animated:YES];
        
    }else
    {
        //TODO;
    }
}

#pragma - mark Helpers


@end
