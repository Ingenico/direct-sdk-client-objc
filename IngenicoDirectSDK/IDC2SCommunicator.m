//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDC2SCommunicator.h"
#import "IDBasicPaymentProductsConverter.h"
#import "IDPaymentProductConverter.h"
#import "IDNetworkingWrapper.h"
#import "IDPaymentAmountOfMoney.h"
#import "IDPaymentContextConverter.h"
#import "IDIINDetailsResponseConverter.h"
#import "IDSDKConstants.h"
#import <PassKit/PKPaymentAuthorizationViewController.h>

@interface IDC2SCommunicator ()

@property (strong, nonatomic) IDC2SCommunicatorConfiguration *configuration;
@property (strong, nonatomic) IDNetworkingWrapper *networkingWrapper;

@end

@implementation IDC2SCommunicator

- (instancetype)initWithConfiguration:(IDC2SCommunicatorConfiguration *)configuration
{
    self = [super init];
    if (self != nil) {
        self.configuration = configuration;
        self.networkingWrapper = [[IDNetworkingWrapper alloc] init];
    }
    return self;
}

- (BOOL)isEnvironmentTypeProduction {
    switch (self.configuration.environment) {
        case IDProduction:
            return YES;
        default:
            return NO;
    }
}

- (void)paymentProductsForContext:(IDPaymentContext *)context success:(void (^)(IDBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure
{
    NSString *isRecurring = context.isRecurring == YES ? @"true" : @"false";
    NSString *URL = [NSString stringWithFormat:@"%@/%@/products?countryCode=%@&locale=%@&currencyCode=%@&amount=%lu&hide=fields&isRecurring=%@", [self baseURL], self.configuration.customerId, context.countryCode, context.locale, context.amountOfMoney.currencyCode, (unsigned long)context.amountOfMoney.totalAmount, isRecurring];
    [self getResponseForURL:URL success:^(id responseObject) {
        NSArray *rawPaymentProducts = [(NSDictionary *)responseObject objectForKey:@"paymentProducts"];
        IDBasicPaymentProductsConverter *converter = [[IDBasicPaymentProductsConverter alloc] init];
        IDBasicPaymentProducts *paymentProducts = [converter paymentProductsFromJSON:rawPaymentProducts];
        [self checkApplePayAvailabilityWithPaymentProducts:paymentProducts forContext:context success:^{
            success(paymentProducts);
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)checkApplePayAvailabilityWithPaymentProducts:(IDBasicPaymentProducts *)paymentProducts forContext:(IDPaymentContext *)context success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    IDBasicPaymentProduct *applePayPaymentProduct = [paymentProducts paymentProductWithIdentifier:kIDApplePayIdentifier];
    if (applePayPaymentProduct != nil) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && [PKPaymentAuthorizationViewController canMakePayments]) {
            [self paymentProductNetworksForProductId:kIDApplePayIdentifier context:context success:^(IDPaymentProductNetworks *paymentProductNetworks) {
                if ([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentProductNetworks.paymentProductNetworks] == NO) {
                    [paymentProducts.paymentProducts removeObject:applePayPaymentProduct];
                }
                success();
            } failure:^(NSError *error) {
                failure(error);
            }];
        } else {
            [paymentProducts.paymentProducts removeObject:applePayPaymentProduct];
            success();
        }
    } else {
        success();
    }
}

- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure {
    NSString *isRecurring = context.isRecurring == YES ? @"true" : @"false";
    NSString *URL = [NSString stringWithFormat:@"%@/%@/products/%@/networks?countryCode=%@&locale=%@&currencyCode=%@&amount=%lu&hide=fields&isRecurring=%@", [self baseURL], self.configuration.customerId, paymentProductId, context.countryCode, context.locale, context.amountOfMoney.currencyCode, (unsigned long)context.amountOfMoney.totalAmount, isRecurring];
    [self getResponseForURL:URL success:^(id responseObject) {
        NSArray *rawProductNetworks = [(NSDictionary *)responseObject objectForKey:@"networks"];
        IDPaymentProductNetworks *paymentProductNetworks = [[IDPaymentProductNetworks alloc] init];
        [paymentProductNetworks.paymentProductNetworks addObjectsFromArray:rawProductNetworks];
        success(paymentProductNetworks);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentProductWithId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(IDPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure
{
    [self checkAvailabilityForPaymentProductWithId:paymentProductId context:context success:^{
        NSString *isRecurring = context.isRecurring == YES ? @"true" : @"false";
        NSString *forceBasicFlow = context.forceBasicFlow == YES ? @"true" : @"false";
        NSString *URL = [NSString stringWithFormat:@"%@/%@/products/%@/?countryCode=%@&locale=%@&currencyCode=%@&amount=%lu&isRecurring=%@&forceBasicFlow=%@", [self baseURL], self.configuration.customerId, paymentProductId, context.countryCode, context.locale, context.amountOfMoney.currencyCode, (unsigned long)context.amountOfMoney.totalAmount, isRecurring, forceBasicFlow];
        [self getResponseForURL:URL success:^(id responseObject) {
            NSDictionary *rawPaymentProduct = (NSDictionary *)responseObject;
            IDPaymentProductConverter *converter = [[IDPaymentProductConverter alloc] init];
            IDPaymentProduct *paymentProduct = [converter paymentProductFromJSON:rawPaymentProduct];

            [self fixProductParametersIfRequired:paymentProduct];

            success(paymentProduct);
        } failure:^(NSError *error) {
            failure(error);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)fixProductParametersIfRequired:(NSObject<IDPaymentItem> *)paymentProduct
{
    NSString *EXPIRY_DATE_MASK = @"{{99}}/{{99}}";
    NSString *REGULAR_CARD_NUMBER_MASK = @"{{9999}} {{9999}} {{9999}} {{9999}}";
    NSString *AMEX_CARD_NUMBER_MASK = @"{{9999}} {{999999}} {{99999}}";
    NSString *AMEX_PRODUCT_ID = @"2";
    NSString *EXPIRY_DATE_FIELD_ID = @"expiryDate";
    NSString *CARD_NUMBER_FIELD_ID = @"cardNumber";

    for (IDPaymentProductField* paymentProductField in paymentProduct.fields.paymentProductFields) {
        NSString *fieldId = paymentProductField.identifier;
        if (![fieldId isEqualToString: EXPIRY_DATE_FIELD_ID] && ![fieldId isEqualToString: CARD_NUMBER_FIELD_ID]) {
            continue;
        }

        if ([fieldId isEqualToString:EXPIRY_DATE_FIELD_ID]) {
            // Fix the field type
            if (paymentProductField.displayHints.formElement.type == IDListType) {
                paymentProductField.displayHints.formElement.type = IDTextType;
            }

            // Add the field mask
            if ([paymentProductField.displayHints.mask length] == 0) {
                paymentProductField.displayHints.mask = EXPIRY_DATE_MASK;
            }
        }

        if ([fieldId isEqualToString:CARD_NUMBER_FIELD_ID] && [paymentProductField.displayHints.mask length] == 0) {
            if ([paymentProduct.identifier isEqualToString:AMEX_PRODUCT_ID]) {
                paymentProductField.displayHints.mask = AMEX_CARD_NUMBER_MASK;
            } else {
                paymentProductField.displayHints.mask = REGULAR_CARD_NUMBER_MASK;
            }
        }
    }
}

- (void)checkAvailabilityForPaymentProductWithId:(NSString *)paymentProductId context:(IDPaymentContext *)context success:(void (^)(void))success failure:(void (^)(NSError *error))failure
{
    if ([paymentProductId isEqualToString:kIDApplePayIdentifier]) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && [PKPaymentAuthorizationViewController canMakePayments]) {
            [self paymentProductNetworksForProductId:kIDApplePayIdentifier context:context success:^(IDPaymentProductNetworks *paymentProductNetworks) {
                if ([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentProductNetworks.paymentProductNetworks] == NO) {
                    failure([self badRequestErrorForPaymentProductId:paymentProductId context:context]);
                } else {
                    success();
                }
            } failure:^(NSError *error) {
                failure(error);
            }];
        } else {
            failure([self badRequestErrorForPaymentProductId:paymentProductId context:context]);
        }
    } else {
        success();
    }
}

- (NSError *)badRequestErrorForPaymentProductId:(NSString *)paymentProductId context:(IDPaymentContext *)context {
    
    NSString *isRecurring = context.isRecurring == YES ? @"true" : @"false";
    NSString *URL = [NSString stringWithFormat:@"%@/%@/products/%@/?countryCode=%@&locale=%@&currencyCode=%@&amount=%lu&isRecurring=%@", [self baseURL], self.configuration.customerId, paymentProductId, context.countryCode, context.locale, context.amountOfMoney.currencyCode, (unsigned long)context.amountOfMoney.totalAmount, isRecurring];
    NSDictionary *errorUserInfo = @{@"com.alamofire.serialization.response.error.response": [[NSHTTPURLResponse alloc] initWithURL:[NSURL fileURLWithPath:URL] statusCode:400 HTTPVersion:nil headerFields:@{@"Connection": @"close"}],
                                    @"NSErrorFailingURLKey": URL,
                                    @"com.alamofire.serialization.response.error.data": [NSData data],
                                    @"NSLocalizedDescription": @"Request failed: bad request (400)"};
    NSError *error = [NSError errorWithDomain:@"com.alamofire.serialization.response.error.response" code:-1011 userInfo:errorUserInfo];
    return error;
}

- (void)publicKey:(void (^)(IDPublicKeyResponse *publicKeyResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *URL = [NSString stringWithFormat:@"%@/%@/crypto/publickey", [self baseURL], self.configuration.customerId];
    [self getResponseForURL:URL success:^(id responseObject) {
        NSDictionary *rawPublicKeyResponse = (NSDictionary *)responseObject;
        NSString *keyId = [rawPublicKeyResponse objectForKey:@"keyId"];
        NSString *encodedPublicKey = [rawPublicKeyResponse objectForKey:@"publicKey"];
        IDPublicKeyResponse *response = [[IDPublicKeyResponse alloc] initWithKeyId:keyId encodedPublicKey:encodedPublicKey];
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentProductIdByPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(IDPaymentContext *)context success:(void (^)(IDIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure {
    NSString *URL = [NSString stringWithFormat:@"%@/%@/services/getIINdetails", [self baseURL], self.configuration.customerId];
    
    NSString *trimmedPartialCreditCardNumber = [self getIINDigitsFrom:partialCreditCardNumber];
    
    NSDictionary *parameters;
    IDPaymentContextConverter *converter = [[IDPaymentContextConverter alloc] init];
    if (context == nil) {
        parameters = [converter JSONFromPartialCreditCardNumber:trimmedPartialCreditCardNumber];
    }
    else {
        parameters = [converter JSONFromPaymentProductContext:context partialCreditCardNumber:trimmedPartialCreditCardNumber];
    }
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:404];
    
    [self postResponseForURL:URL withParameters:parameters additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        IDIINDetailsResponseConverter *converter = [[IDIINDetailsResponseConverter alloc] init];
        IDIINDetailsResponse *IINDetails = [converter IINDetailsResponseFromJSON:response];
        success(IINDetails);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSString *)getIINDigitsFrom:(NSString *)partialCreditCardNumber {
    int max;
    if (partialCreditCardNumber.length >= 8) {
        max = 8;
    }
    else {
        max = (int) MIN(partialCreditCardNumber.length, 6);
    }
    return [partialCreditCardNumber substringToIndex:max];
}

- (NSDictionary *)headers
{
    NSDictionary *headers = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"GCS v1Client:%@", self.clientSessionId], @"Authorization", self.base64EncodedClientMetaInfo, @"X-GCS-ClientMetaInfo", nil];
    return headers;
}

- (void)getResponseForURL:(NSString *)URL success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self.networkingWrapper getResponseForURL:URL headers:[self headers] additionalAcceptableStatusCodes:nil success:success failure:failure];
}

- (void)postResponseForURL:(NSString *)URL withParameters:(NSDictionary *)parameters additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self.networkingWrapper postResponseForURL:URL headers:[self headers] withParameters:parameters additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:success failure:failure];
}

- (NSString *)baseURL
{
    return [self.configuration baseURL];
}

-(void)setBaseURL:(NSString *)baseURL {
    [self.configuration setBaseURL:baseURL];
}

-(void)setAssetsBaseURL:(NSString *)assetsBaseURL {
    [self.configuration setAssetsBaseURL:assetsBaseURL];
}

- (NSString *)assetsBaseURL
{
    return [self.configuration assetsBaseURL];
}

- (NSString *)base64EncodedClientMetaInfo
{
    return [self.configuration base64EncodedClientMetaInfo];
}

- (NSString *)clientSessionId
{
    return [self.configuration clientSessionId];
}

@end
