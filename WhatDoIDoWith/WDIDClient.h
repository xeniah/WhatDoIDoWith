//
//  WDIDClient.h
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^CallbackBlock)();

typedef void (^JSONBlock)(id JSON);

typedef JSONBlock SuccessBlock;

typedef void (^FailureBlock)(NSError *error);

typedef void (^HandleServerResponseBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface WDIDClient : NSObject
+ (WDIDClient *)sharedClient;
- (void)getJson:(NSString *)uri parameters:(NSDictionary *)parameters success:(SuccessBlock)success failureWithResponse:(HandleServerResponseBlock)failure;
@end
