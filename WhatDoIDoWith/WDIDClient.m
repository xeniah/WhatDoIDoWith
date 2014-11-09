//
//  WDIDClient.m
//  WhatDoIDoWith
//
//  Created by XeniaH on 11/2/14.
//  Copyright (c) 2014 xeniah. All rights reserved.
//

#import "WDIDClient.h"
#import <AFNetworking/AFNetworking.h>

@interface WDIDClient ()
    @property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation WDIDClient

static WDIDClient *_sharedClient = nil;

+ (WDIDClient *)sharedClient {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        [self setupSharedClient];
        
    });
    return _sharedClient;
}

+ (void)setupSharedClient {
    _sharedClient = [[WDIDClient alloc] init];
}


- (WDIDClient *)init {
    self = [super init];
    if (self) {
        self.manager =[[ AFHTTPRequestOperationManager alloc] init];
    }
    return self;
}

- (void)getJson:(NSString *)uri parameters:(NSDictionary *)parameters success:(SuccessBlock)success failureWithResponse:(HandleServerResponseBlock)failure {
    [self startJsonRequest:uri method:@"GET" parameters:parameters body:nil success:success failure:failure];
}

- (void)startJsonRequest:(NSString *)uri method:(NSString *)method parameters:(NSDictionary *)parameters body:(id)body success:(SuccessBlock)success failure:(HandleServerResponseBlock)failure {

    NSURLRequest *request = [_manager.requestSerializer requestWithMethod:method URLString:uri parameters:parameters error:nil];

    request = [[AFJSONRequestSerializer serializer] requestBySerializingRequest:request withParameters:body error:nil];

    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) success(responseObject);
     }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if (failure) failure(operation, error);
     }];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [_manager.operationQueue addOperation:operation];
}

@end
