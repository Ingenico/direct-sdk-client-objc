//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidatorLuhn.h"
#import "IDValidationErrorLuhn.h"

@implementation IDValidatorLuhn

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSInteger evenSum = 0;
    NSInteger oddSum = 0;
    NSInteger digit;
    for (int i = 1; i <= value.length; ++i) {
        unsigned long j = value.length - i;
        digit = [[NSString stringWithFormat:@"%C", [value characterAtIndex:j]] integerValue];
        if (i % 2 == 1) {
            evenSum += digit;
        } else {
            digit = digit * 2;
            digit = (digit % 10) + (digit / 10);
            oddSum += digit;
        }
    }
    NSInteger total = evenSum + oddSum;
    if (total % 10 != 0) {
        IDValidationErrorLuhn *error = [[IDValidationErrorLuhn alloc] init];
        [self.errors addObject:error];
    }
}

@end
