//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

#import "IDRegion.h"
#import "IDUtil.h"
#import "IDEnvironment.h"

@interface IDC2SCommunicatorConfiguration : NSObject {
    NSString *_baseURL;
}

@property (strong, nonatomic) NSString *clientSessionId;
@property (strong, nonatomic) NSString *customerId;
@property (nonatomic) IDRegion region;
@property (nonatomic) IDEnvironment environment;

@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *ipAddress;

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *assetsBaseURL;

- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment util:(IDUtil *)util __deprecated_msg("use method initWithClientSessionId:baseURL:assetBaseURL:environment:appIdentifier:ipAddress:util: instead");
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment appIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress util:(IDUtil *)util __deprecated_msg("use method initWithClientSessionId:baseURL:assetBaseURL:environment:appIdentifier:ipAddress:util: instead");
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment appIdentifier:(NSString *)appIdentifier util:(IDUtil *)util __deprecated_msg("use method initWithClientSessionId:baseURL:assetBaseURL:environment:appIdentifier:ipAddress:util: instead");
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier util:(IDUtil *)util;
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress util:(IDUtil *)util;
- (NSString *)base64EncodedClientMetaInfo;

@end
