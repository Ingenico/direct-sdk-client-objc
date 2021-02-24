//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDIINDetailsResponse.h"

@implementation IDIINDetailsResponse

- (instancetype)initWithStatus:(IDIINStatus)status {
    self = [super init];
    if (self) {
        _status = status;
    }

    return self;
}

- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId status:(IDIINStatus)status coBrands:(NSArray *)coBrands countryCode:(NSString *)countryCode allowedInContext:(BOOL)allowedInContext {
    self = [super init];
    if (self) {
        _paymentProductId = paymentProductId;
        _status = status;
        _coBrands = coBrands;
        _countryCode = countryCode;
        _allowedInContext = allowedInContext;
    }

    return self;
}

@end
