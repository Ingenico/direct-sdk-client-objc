//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

#import "IDPaymentRequest.h"
#import "IDBasicPaymentProducts.h"
#import "IDC2SCommunicator.h"
#import "IDIINDetailsResponse.h"
#import "IDPreparedPaymentRequest.h"
#import "IDPaymentContext.h"
#import "IDAssetManager.h"
#import "IDJOSEEncryptor.h"

@interface IDSession : NSObject
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *assetsBaseURL;

- (instancetype)initWithCommunicator:(IDC2SCommunicator *)communicator assetManager:(IDAssetManager *)assetManager encryptor:(IDEncryptor *)encryptor JOSEEncryptor:(IDJOSEEncryptor *)JOSEEncryptor stringFormatter:(IDStringFormatter *)stringFormatter;
+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment __deprecated_msg("use sessionWithClientSessionId:customerId:baseURL:assetBaseURL:appIdentifier: instead");
+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment appIdentifier:(NSString *)appIdentifier __deprecated_msg("use sessionWithClientSessionId:customerId:baseURL:assetBaseURL:appIdentifier: instead");
+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier;

- (void)paymentProductsForContext:(IDPaymentContext *)context success:(void (^)(IDBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure;
- (void)paymentItemsForContext:(IDPaymentContext *)context groupPaymentProducts:(BOOL)groupPaymentProducts success:(void (^)(IDPaymentItems *paymentItems))success failure:(void (^)(NSError *error))failure;

- (void)paymentProductWithId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure;

- (void)IINDetailsForPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(IDPaymentContext *)context success:(void (^)(IDIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure;
- (void)preparePaymentRequest:(IDPaymentRequest *)paymentRequest success:(void (^)(IDPreparedPaymentRequest *preparedPaymentRequest))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure;
- (BOOL)isEnvironmentTypeProduction;

@end
