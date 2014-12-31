//
//  WDIDProviderDetailViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProviderDetailViewController.h"
#import "WDIDProviderDetailTableViewCell.h"
#import "WDIDProviderWebPageViewController.h"
#import "UIView+Resize.h"
#import "Constants.h"

@interface WDIDProviderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;
@property (nonatomic, strong) NSArray *providerDetailTitles;
@property (weak, nonatomic) IBOutlet UILabel *providerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *providerServiceDescriptionLabel;

@end


#define PHONE_INDEX             0
#define ADDRESS_INDEX           1
#define CITY_INDEX              2
#define ZIPCODE_INDEX           3
#define WEBPAGE_INDEX           4
#define FEE_INDEX               6
#define VIEW_ON_MAP_INDEX       7
#define HOURS_INDEX             10

@implementation WDIDProviderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Provider Details";
    self.providerDetailTitles = @[@"Phone", @"Address", @"City", @"Zipcode", @"Go to Webpage"];
    self.providerNameLabel.text = self.provider.providerName;
    self.providerNameLabel.preferredMaxLayoutWidth = self.providerNameLabel.frame.size.width;
    self.providerNameLabel.textColor = [UIColor whiteColor];
    self.providerServiceDescriptionLabel.text = self.provider.providerServiceDescription;
    self.providerServiceDescriptionLabel.textColor = [UIColor whiteColor];
    self.providerServiceDescriptionLabel.preferredMaxLayoutWidth = self.providerServiceDescriptionLabel.frame.size.width;
    self.tableViewHeader.backgroundColor = SALAD_GREEN_BG;
       
    [UIView animateWithDuration:0.35 animations:^{
         [self.providerServiceDescriptionLabel sizeToFit];
         [self.providerNameLabel sizeToFit];
        [self.tableViewHeader resizeToFitSubviews];
     }];
    self.tableView.tableHeaderView = self.tableViewHeader;
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
    
    cell.titleLabel.text = self.providerDetailTitles[indexPath.row];
    NSString *infoText;
   
    switch (indexPath.row) {
        case PHONE_INDEX:
            infoText = self.provider.providerPhoneNumber;
            break;
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
    if(indexPath.row == WEBPAGE_INDEX && self.provider.providerURL!= nil && self.provider.providerURL.length > 0)
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
