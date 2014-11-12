//
//  WDIDMapViewController.m
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/11/14.
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
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // iOS8+
        [[UIApplication sharedApplication] sendAction:@selector(requestWhenInUseAuthorization)
                                                   to:self.locationManager
                                                 from:self
                                             forEvent:nil];
    }
   
    for(WDIDProvider *provider in self.providers)
    {
        NSLog(@"%f, %f", [provider.latitude doubleValue], [provider.longitude doubleValue]);
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



@end
