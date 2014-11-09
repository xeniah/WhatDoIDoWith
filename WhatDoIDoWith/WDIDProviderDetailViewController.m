//
//  WDIDProviderDetailViewController.m
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/9/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDProviderDetailViewController.h"
#import "WDIDProviderWebPageViewController.h"

@interface WDIDProviderDetailViewController ()
//@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;
@property (nonatomic, strong) NSArray *providerDetailTitles;

@end

@implementation WDIDProviderDetailViewController

- (instancetype)initWithProvider:(WDIDProvider *)aProvider
{
    {
        if(self = [super init])
        {
            self.provider = aProvider;
            self.providerDetailTitles = @[@"Name", @"Address", @"City", @"Zipcode", @"Description", @"Restrictions", @"Fee", @"View On Map", @"Go to Webpage"];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.provider.providerName;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"providerDetailCell"]; // TODO
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"providerDetailCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.providerDetailTitles[indexPath.row];

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 8 && self.provider.providerURL!= nil && self.provider.providerURL.length > 0) // TODO
    {
//        NSURL *url = [ [ NSURL alloc ] initWithString:self.provider.providerURL];
//        [[UIApplication sharedApplication] openURL:url];
        WDIDProviderWebPageViewController *webPageController = [[WDIDProviderWebPageViewController alloc]initWithURLStr:self.provider.providerURL];
        [self.navigationController pushViewController:webPageController animated:YES];
        
    }else
    {
        //TODO;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
