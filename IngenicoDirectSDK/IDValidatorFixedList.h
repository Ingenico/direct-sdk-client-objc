//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidator.h"

@interface IDValidatorFixedList : IDValidator

@property (strong, nonatomic, readonly) NSArray *allowedValues;

- (instancetype)initWithAllowedValues:(NSArray *)allowedValues;

@end
