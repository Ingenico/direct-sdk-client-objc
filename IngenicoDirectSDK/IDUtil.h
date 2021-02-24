//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDRegion.h"
#import "IDEnvironment.h"

@interface IDUtil : NSObject

- (NSString *)base64EncodedClientMetaInfo __deprecated_msg("use method base64EncodedClientMetaInfoWithAppIdentifier:ipAddress: instead");
- (NSString *)base64EncodedClientMetaInfoWithAddedData:(NSDictionary *)addedData __deprecated_msg("use method base64EncodedClientMetaInfoWithAppIdentifier:ipAddress:addedData: instead");;
- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier;
- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress;
- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress addedData:(NSDictionary *)addedData;

- (NSString *)C2SBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment;
- (NSString *)assetsBaseURLByRegion:(IDRegion)region environment:(IDEnvironment)environment;

@end
