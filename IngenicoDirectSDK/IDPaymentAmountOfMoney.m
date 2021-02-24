//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDPaymentAmountOfMoney.h"
#import "IDSDKConstants.h"

@implementation IDPaymentAmountOfMoney

- (instancetype)initWithTotalAmount:(long)totalAmount currencyCode:(NSString *)currencyCode {
    if ([kIDCurrencyCodes rangeOfString:currencyCode].location == NSNotFound) {
        [NSException raise:@"Invalid currency code" format:@"Currency code %@ is invalid", currencyCode];
    }

    self = [super init];
    if (self) {
        _totalAmount = totalAmount;
        _currencyCode = currencyCode;
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld-%@", (long) self.totalAmount, self.currencyCode];
}

@end
