//
//  WDIDProvider.h
//  WhatDoIDoWith
//
//  Created by Pugetworks on 11/8/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WDIDCategory;

@interface WDIDProvider : NSManagedObject

@property (nonatomic, retain) NSString * entityId;
@property (nonatomic, retain) NSString * providerAddress;
@property (nonatomic, retain) NSString * providerCity;
@property (nonatomic, retain) NSString * providerHours;
@property (nonatomic, retain) NSString * providerName;
@property (nonatomic, retain) NSString * providerState;
@property (nonatomic, retain) NSString * providerZip;
@property (nonatomic, retain) NSString * providerServiceDescription;
@property (nonatomic, retain) NSString * providerRestrictions;
@property (nonatomic, retain) NSString * providerFee;
@property (nonatomic, retain) NSString * providerURL;
@property (nonatomic, retain) NSString * providerPhoneNumber;
@property (nonatomic, retain) NSSet *categories;
@end

@interface WDIDProvider (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(WDIDCategory *)value;
- (void)removeCategoriesObject:(WDIDCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
