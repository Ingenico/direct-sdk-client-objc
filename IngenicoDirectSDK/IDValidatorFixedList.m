//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidatorFixedList.h"
#import "IDValidationErrorFixedList.h"

@implementation IDValidatorFixedList

- (instancetype) initWithAllowedValues:(NSArray *)allowedValues
{
    self = [super init];
    if (self != nil) {
        _allowedValues = allowedValues;
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    for (NSString *allowedValue in self.allowedValues) {
        if ([allowedValue isEqualToString:value] == YES) {
            return;
        }
    }
    IDValidationErrorFixedList *error = [[IDValidationErrorFixedList alloc] init];
    [self.errors addObject:error];
}

@end
