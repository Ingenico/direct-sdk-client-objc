//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidatorLength.h"
#import "IDValidationErrorLength.h"

@implementation IDValidatorLength

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    IDValidationErrorLength *error = [[IDValidationErrorLength alloc] init];
    error.minLength = self.minLength;
    error.maxLength = self.maxLength;
    if (value.length < self.minLength) {
        [self.errors addObject:error];
    }
    if (value.length > self.maxLength) {
        [self.errors addObject:error];
    }
}

@end
