//
//  JSONUtils.h
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtils : NSObject
+ (JSONUtils *) sharedJSONUtils;
//- (void)processJSONCategories;
- (void)processJSONProviders:(NSDictionary *)dictionary;
@end
