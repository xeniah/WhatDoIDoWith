//
//  WDIDMapViewController.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/11/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDMapViewController.h"
#import "WDIDProvider.h"

@interface WDIDMapViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation WDIDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(listButtonClicked:)];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6514, -122.3509);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate,10000, 10000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[UIApplication sharedApplication] sendAction:@selector(requestWhenInUseAuthorization)
                                                   to:self.locationManager
                                                 from:self
                                             forEvent:nil];
    }

    self.mapView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.mapView.showsUserLocation = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.mapView.showsUserLocation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark MKMapViewCandidate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,10000, 10000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    for(WDIDProvider* provider in self.providers)
    {
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([provider.latitude doubleValue], [provider.longitude doubleValue]);
        point.coordinate = coordinate;
        point.title = provider.providerName;
        point.subtitle = provider.providerPhoneNumber;
        
        [self.mapView addAnnotation:point];
    }
}

#pragma mark IBActions
- (IBAction)listButtonClicked:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:@"SlideDown"];
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
