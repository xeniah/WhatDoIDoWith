//
//  WDIDCategory.h
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/8/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WDIDProvider;

@interface WDIDCategory : NSManagedObject

@property (nonatomic, retain) NSString * entityId;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSSet *providers;
@end

@interface WDIDCategory (CoreDataGeneratedAccessors)

- (void)addProvidersObject:(WDIDProvider *)value;
- (void)removeProvidersObject:(WDIDProvider *)value;
- (void)addProviders:(NSSet *)values;
- (void)removeProviders:(NSSet *)values;

@end
