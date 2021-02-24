//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDStubUtil.h"

@implementation IDStubUtil

- (NSString *)C2SBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment
{
    return @"c2sbaseurlbyregion";
}

- (NSString *)assetsBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment
{
    return @"assetsbaseurlbyregion";
}

- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress addedData:(NSDictionary *)addedData {
    return @"base64encodedclientmetainfo";
}

@end
