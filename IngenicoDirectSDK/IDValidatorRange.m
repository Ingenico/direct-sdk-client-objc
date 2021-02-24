//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidatorRange.h"
#import "IDValidationErrorRange.h"

@interface IDValidatorRange ()

@property (strong, nonatomic) NSNumberFormatter *formatter;

@end

@implementation IDValidatorRange

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.formatter = [[NSNumberFormatter alloc] init];
        self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSNumber *number = [self.formatter numberFromString:value];
    NSInteger valueAsInteger = [number integerValue];
    IDValidationErrorRange *error = [[IDValidationErrorRange alloc] init];
    error.minValue = self.minValue;
    error.maxValue = self.maxValue;
    if (number == nil) {
        [self.errors addObject:error];
    } else if (valueAsInteger < self.minValue) {
        [self.errors addObject:error];
    } else if (valueAsInteger > self.maxValue) {
        [self.errors addObject:error];
    }
}

@end
