//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDIINDetail.h"

@implementation IDIINDetail

- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId allowedInContext:(BOOL)allowedInContext {
    self = [super init];
    if (self) {
        _paymentProductId = paymentProductId;
        _allowedInContext = allowedInContext;
    }

    return self;
}

@end
