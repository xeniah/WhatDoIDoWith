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
        wdidProvider.providerURL = [self value:provider forIndex:29];
        
        NSString *m = provider[16];
        NSArray *materials = [m componentsSeparatedByString:@", "];
        for(NSString *s in materials)
        {
            WDIDCategory *wdidCategory = [delegate fetch:WDIDCATEGORY_TYPE orCreate:YES withEntityId:s];
            wdidCategory.categoryName = s;
            [wdidProvider addCategoriesObject:wdidCategory];
        }
        
    }
    
    [delegate saveContext];
}
/*
- (void)processJSONCategories
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"json"];
    NSString *jsonStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;
    NSArray *categories = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if(error)
    {
        NSLog(@"Error: %@", error.localizedDescription);
    }else
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
       
        for(NSDictionary *d in categories)
        {
            long categoryId = [d[@"category_id"] longValue];
            WDIDCategory * category = [delegate fetch:@"WDIDCategory" orCreate:YES withEntityId:categoryId]; //TODO: WDIDCategory -> #define
            category.categoryName = d[@"category_name"];
        }
        
        [delegate saveContext];
    }
}
 */

#pragma mark helpers
- (NSString *)value:(NSArray *)provider forIndex:(int)index
{
    return (provider[index] != (id)[NSNull null])? provider[index] : @"";
}
@end
