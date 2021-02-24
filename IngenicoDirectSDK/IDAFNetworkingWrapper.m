//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDAFNetworkingWrapper.h"
#import "IDNetworkingWrapper.h"

@interface IDAFNetworkingWrapper ()

    @property (strong, nonatomic) IDNetworkingWrapper *_idNetworkingWrapper;

@end

@implementation IDAFNetworkingWrapper

- (instancetype)init {

    self._idNetworkingWrapper = [[IDNetworkingWrapper alloc] init];

    return self;
}


- (void)getResponseForURL:(NSString *)URL headers:(NSDictionary *)headers additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"IDAFNetworkingWrapper is deprecated! Please use IDNetworkingWrapper instead.");
    [self._idNetworkingWrapper getResponseForURL:URL headers:headers additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:success failure:failure];
}


- (void)postResponseForURL:(NSString *)URL headers:(NSDictionary *)headers withParameters:(NSDictionary *)parameters additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"IDAFNetworkingWrapper is deprecated! Please use IDNetworkingWrapper instead.");
    [self._idNetworkingWrapper postResponseForURL:URL headers:headers withParameters:parameters additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:success failure:failure];
}

@end
