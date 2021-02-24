//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidatorTermsAndConditions.h"
#import "IDValidatorRegularExpression.h"
#import "IDValidationErrorTermsAndConditions.h"

@implementation IDValidatorTermsAndConditions

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    if (![@"true" isEqualToString:value]) {
        [self.errors addObject:[[IDValidationErrorTermsAndConditions alloc]init]];
    }
}

@end
