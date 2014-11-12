//
//  WDIDMapViewController.h
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/11/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WDIDMapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic, strong) NSArray *providers;
@end
