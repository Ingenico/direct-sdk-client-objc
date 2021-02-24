//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDSession.h"
#import "IDBase64.h"
#import "IDJSON.h"
#import "IDSDKConstants.h"
#import "IDPaymentItems.h"
#import <PassKit/PassKit.h>

@interface IDSession ()

@property (strong, nonatomic) IDC2SCommunicator *communicator;
@property (strong, nonatomic) IDAssetManager *assetManager;
@property (strong, nonatomic) IDEncryptor *encryptor;
@property (strong, nonatomic) IDJOSEEncryptor *JOSEEncryptor;
@property (strong, nonatomic) IDStringFormatter *stringFormatter;
@property (strong, nonatomic) IDBasicPaymentProducts *paymentProducts;
@property (strong, nonatomic) NSMutableDictionary *paymentProductMapping;
@property (strong, nonatomic) IDBase64 *base64;
@property (strong, nonatomic) IDJSON *JSON;
@property (strong, nonatomic) NSMutableDictionary *IINMapping;
@property (assign, nonatomic) BOOL iinLookupPending;

@end

@implementation IDSession

- (instancetype)initWithCommunicator:(IDC2SCommunicator *)communicator assetManager:(IDAssetManager *)assetManager encryptor:(IDEncryptor *)encryptor JOSEEncryptor:(IDJOSEEncryptor *)JOSEEncryptor stringFormatter:(IDStringFormatter *)stringFormatter
{
    self = [super init];
    if (self != nil) {
        self.base64 = [[IDBase64 alloc] init];
        self.JSON = [[IDJSON alloc] init];
        self.communicator = communicator;
        self.assetManager = assetManager;
        self.encryptor = encryptor;
        self.JOSEEncryptor = JOSEEncryptor;
        self.stringFormatter = stringFormatter;
        self.IINMapping = [[StandardUserDefaults objectForKey:kIDIINMapping] mutableCopy];
        if (self.IINMapping == nil) {
            self.IINMapping = [[NSMutableDictionary alloc] init];
        }
        self.paymentProductMapping = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSString *)baseURL {
    return [self.communicator baseURL];
}

-(NSString *)assetsBaseURL {
    return [self.communicator assetsBaseURL];
}

+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier{
    IDUtil *util = [[IDUtil alloc] init];
    IDAssetManager *assetManager = [[IDAssetManager alloc] init];
    IDStringFormatter *stringFormatter = [[IDStringFormatter alloc] init];
    IDEncryptor *encryptor = [[IDEncryptor alloc] init];
    IDC2SCommunicatorConfiguration *configuration = [[IDC2SCommunicatorConfiguration alloc] initWithClientSessionId:clientSessionId customerId:customerId baseURL:baseURL assetBaseURL:assetBaseURL appIdentifier:appIdentifier util:util];
    IDC2SCommunicator *communicator = [[IDC2SCommunicator alloc] initWithConfiguration:configuration];
    IDJOSEEncryptor *JOSEEncryptor = [[IDJOSEEncryptor alloc] initWithEncryptor:encryptor];
    IDSession *session = [[IDSession alloc] initWithCommunicator:communicator assetManager:assetManager encryptor:encryptor JOSEEncryptor:JOSEEncryptor stringFormatter:stringFormatter];
    return session;
}

+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment
{
    return [self sessionWithClientSessionId:clientSessionId customerId:customerId region:region environment:environment appIdentifier:nil];
}

+ (IDSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId region:(IDRegion)region environment:(IDEnvironment)environment appIdentifier:(NSString *)appIdentifier {
    IDUtil *util = [[IDUtil alloc] init];
    IDAssetManager *assetManager = [[IDAssetManager alloc] init];
    IDStringFormatter *stringFormatter = [[IDStringFormatter alloc] init];
    IDEncryptor *encryptor = [[IDEncryptor alloc] init];
    IDC2SCommunicatorConfiguration *configuration = [[IDC2SCommunicatorConfiguration alloc] initWithClientSessionId:clientSessionId customerId:customerId region:region environment:environment appIdentifier:appIdentifier util:util];
    IDC2SCommunicator *communicator = [[IDC2SCommunicator alloc] initWithConfiguration:configuration];
    IDJOSEEncryptor *JOSEEncryptor = [[IDJOSEEncryptor alloc] initWithEncryptor:encryptor];
    IDSession *session = [[IDSession alloc] initWithCommunicator:communicator assetManager:assetManager encryptor:encryptor JOSEEncryptor:JOSEEncryptor stringFormatter:stringFormatter];
    return session;
}


- (void)paymentProductsForContext:(IDPaymentContext *)context success:(void (^)(IDBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure
{
    [self.communicator paymentProductsForContext:context success:^(IDBasicPaymentProducts *paymentProducts) {
        self.paymentProducts = paymentProducts;
        self.paymentProducts.stringFormatter = self.stringFormatter;
        [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
        [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProducts.paymentProducts baseURL:[self.communicator assetsBaseURL] callback:^{
            [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
            success(paymentProducts);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure {
    [self.communicator paymentProductNetworksForProductId:paymentProductId context:context success:^(IDPaymentProductNetworks *paymentProductNetworks) {
        success(paymentProductNetworks);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentItemsForContext:(IDPaymentContext *)context groupPaymentProducts:(BOOL)groupPaymentProducts success:(void (^)(IDPaymentItems *paymentItems))success failure:(void (^)(NSError *error))failure {
    [self.communicator paymentProductsForContext:context success:^(IDBasicPaymentProducts *paymentProducts) {
        self.paymentProducts = paymentProducts;
        self.paymentProducts.stringFormatter = self.stringFormatter;
        [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
        [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProducts.paymentProducts baseURL:[self.communicator assetsBaseURL] callback:^{
            [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
                IDPaymentItems *items = [[IDPaymentItems alloc] initWithPaymentProducts:paymentProducts groups:nil];
                success(items);
        }];

    } failure:failure];
}

- (void)paymentProductWithId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure
{
    NSString *key = [NSString stringWithFormat:@"%@-%@", paymentProductId, [context description]];
    IDPaymentProduct *paymentProduct = [self.paymentProductMapping objectForKey:key];
    if (paymentProduct != nil) {
        success(paymentProduct);
    } else {
        [self.communicator paymentProductWithId:paymentProductId context:context success:^(IDPaymentProduct *paymentProduct) {
            [self.paymentProductMapping setObject:paymentProduct forKey:key];
            [self.assetManager initializeImagesForPaymentItem:paymentProduct];
            [self.assetManager updateImagesForPaymentItemAsynchronously:paymentProduct baseURL:[self.communicator assetsBaseURL] callback:^{
                [self.assetManager initializeImagesForPaymentItem:paymentProduct];
                success(paymentProduct);
            }];
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)IINDetailsForPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(IDPaymentContext *)context success:(void (^)(IDIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure
{
    if (partialCreditCardNumber.length < 6) {
        IDIINDetailsResponse *response = [[IDIINDetailsResponse alloc] initWithStatus:IDNotEnoughDigits];
        success(response);
    } else if (self.iinLookupPending == YES) {
        IDIINDetailsResponse *response = [[IDIINDetailsResponse alloc] initWithStatus:IDPending];
        success(response);
    }
    else {
        self.iinLookupPending = YES;
        [self.communicator paymentProductIdByPartialCreditCardNumber:partialCreditCardNumber context:context success:^(IDIINDetailsResponse *response) {
            self.iinLookupPending = NO;
            success(response);
        } failure:^(NSError *error) {
            self.iinLookupPending = NO;
            failure(error);
        }];
    }
}

- (void)preparePaymentRequest:(IDPaymentRequest *)paymentRequest success:(void (^)(IDPreparedPaymentRequest *preparedPaymentRequest))success failure:(void (^)(NSError *error))failure;
{
    [self.communicator publicKey:^(IDPublicKeyResponse *publicKeyResponse) {
        NSString *keyId = publicKeyResponse.keyId;
        
        NSString *encodedPublicKey = publicKeyResponse.encodedPublicKey;
        NSData *publicKeyAsData = [self.base64 decode:encodedPublicKey];
        NSData *strippedPublicKeyAsData = [self.encryptor stripPublicKey:publicKeyAsData];
        NSString *tag = @"globalcollect-sdk-public-key";
        [self.encryptor deleteRSAKeyWithTag:tag];
        [self.encryptor storePublicKey:strippedPublicKeyAsData tag:tag];
        SecKeyRef publicKey = [self.encryptor RSAKeyWithTag:tag];
        
        IDPreparedPaymentRequest *preparedRequest = [[IDPreparedPaymentRequest alloc] init];
        NSMutableString *paymentRequestJSON = [[NSMutableString alloc] init];
        NSString *clientSessionId = [NSString stringWithFormat:@"{\"clientSessionId\": \"%@\", ", [self clientSessionId]];
        [paymentRequestJSON appendString:clientSessionId];
        NSString *nonce = [NSString stringWithFormat:@"\"nonce\": \"%@\", ", [self.encryptor UUID]];
        [paymentRequestJSON appendString:nonce];
        NSString *paymentProduct = [NSString stringWithFormat:@"\"paymentProductId\": %ld, ", (long)[paymentRequest.paymentProduct.identifier integerValue]];
        [paymentRequestJSON appendString:paymentProduct];
        if (paymentRequest.accountOnFile != nil) {
            NSString *accountOnFile = [NSString stringWithFormat:@"\"accountOnFileId\": %ld, ", (long)[paymentRequest.accountOnFile.identifier integerValue]];
            [paymentRequestJSON appendString:accountOnFile];
        }
        if (paymentRequest.tokenize == YES) {
            NSString *tokenize = @"\"tokenize\": true, ";
            [paymentRequestJSON appendString:tokenize];
        }
        NSString *paymentValues = [NSString stringWithFormat:@"\"paymentValues\": %@}", [self.JSON keyValueJSONFromDictionary:paymentRequest.unmaskedFieldValues]];
        [paymentRequestJSON appendString:paymentValues];
        preparedRequest.encryptedFields = [self.JOSEEncryptor encryptToCompactSerialization:paymentRequestJSON withPublicKey:publicKey keyId:keyId];
        preparedRequest.encodedClientMetaInfo = [self.communicator base64EncodedClientMetaInfo];
        success(preparedRequest);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSString *)clientSessionId
{
    return [self.communicator clientSessionId];
}

- (BOOL)isEnvironmentTypeProduction
{
    return [self.communicator isEnvironmentTypeProduction];
}

@end
