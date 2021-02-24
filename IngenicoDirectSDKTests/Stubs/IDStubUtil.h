//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDUtil.h"

@interface IDStubUtil : IDUtil

- (NSString *)C2SBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment;
- (NSString *)assetsBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment;
- (NSString *)base64EncodedClientMetaInfo;

@end
