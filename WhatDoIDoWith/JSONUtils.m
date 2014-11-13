//
//  JSONUtils.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "JSONUtils.h"
#import "AppDelegate.h"
#import "WDIDCategory.h"
#import "WDIDProvider.h"

@implementation JSONUtils
static JSONUtils *_sharedUtils = nil;

+ (JSONUtils *) sharedJSONUtils
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUtils = [[JSONUtils alloc]init];
    });
    return _sharedUtils;
}

- (void)processJSONProviders:(NSDictionary *)jsonDict
{
    NSArray *data = jsonDict[@"data"];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    for(NSArray *provider in data)
    {
        [self createProviderEntity:provider delegate:delegate];
        
    }
    
    [delegate saveContext];
}

#pragma mark helpers

- (void)createProviderEntity:(NSArray *)provider delegate:delegate
{
    NSString *providerId = provider[8];
    WDIDProvider * wdidProvider = [delegate fetch:WDIDPROVIDER_TYPE orCreate:YES withEntityId:providerId];
    
    wdidProvider.providerAddress = [self value:provider forIndex:10];
    wdidProvider.providerName = [self value:provider forIndex:9];
    wdidProvider.providerCity = [self value:provider forIndex:11];
    wdidProvider.providerState = @"WA";
    wdidProvider.providerZip = [self value:provider forIndex:12];
    wdidProvider.providerHours = [self value:provider forIndex:15];
    
    wdidProvider.providerFee = [self value:provider forIndex:22];
    wdidProvider.providerServiceDescription = [self value:provider forIndex:17];
    wdidProvider.providerRestrictions = [self value:provider forIndex:18];
    
    // get the phoneNumber
    NSArray *phoneN = provider[13];
    if(phoneN && phoneN.count > 0)
    {
        NSString *phoneNumStr = phoneN[0];
        wdidProvider.providerPhoneNumber = phoneNumStr;
    }
    
    // get the provider's URL, if available
    NSArray *providerURI = provider[29];
    if(providerURI && providerURI.count > 0)
    {
        wdidProvider.providerURL = [self value:providerURI forIndex:0];;
    }
    
    // get provider's address
    NSArray *geoAddress = provider[31];
    if(geoAddress && geoAddress.count > 2)
    {
        double latitude = (geoAddress[1] != (id)[NSNull null])? [geoAddress[1] doubleValue]:0;
        double longitude = (geoAddress[2] != (id)[NSNull null])?[geoAddress[2] doubleValue]:0;
        wdidProvider.latitude = [NSNumber numberWithDouble:latitude];
        wdidProvider.longitude = [NSNumber numberWithDouble:longitude];
    }
    
    // connect categories to provider
    NSString *m = provider[16];
    NSArray *materials = [m componentsSeparatedByString:@", "];
    for(NSString *s in materials)
    {
        WDIDCategory *wdidCategory = [delegate fetch:WDIDCATEGORY_TYPE orCreate:YES withEntityId:s];
        wdidCategory.categoryName = s;
        [wdidProvider addCategoriesObject:wdidCategory];
    }
}

- (NSString *)value:(NSArray *)provider forIndex:(int)index
{
    return (provider[index] != (id)[NSNull null])? provider[index] : @"";
}
@end
