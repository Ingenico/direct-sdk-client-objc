//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDC2SCommunicatorConfiguration.h"
#import "IDPaymentContext.h"
#import "IDPublicKeyResponse.h"
#import "IDBasicPaymentProducts.h"
#import "IDPaymentProduct.h"
#import "IDAssetManager.h"
#import "IDStringFormatter.h"
#import "IDIINDetailsResponse.h"
#import "IDPaymentProductNetworks.h"

@class IDBasicPaymentProductGroups;
@class IDPaymentProductGroup;
@interface IDC2SCommunicator : NSObject

- (instancetype)initWithConfiguration:(IDC2SCommunicatorConfiguration *)configuration;
- (void)paymentProductsForContext:(IDPaymentContext *)context success:(void (^)(IDBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductWithId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductIdByPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(IDPaymentContext *)context success:(void (^)(IDIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure;
- (void)publicKey:(void (^)(IDPublicKeyResponse *publicKeyResponse))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure;
- (NSString *)base64EncodedClientMetaInfo;
- (NSString *)baseURL;
- (NSString *)assetsBaseURL;
- (NSString *)clientSessionId;

- (BOOL)isEnvironmentTypeProduction;

@end
