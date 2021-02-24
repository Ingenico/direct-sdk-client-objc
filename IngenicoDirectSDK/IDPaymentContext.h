//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDPaymentAmountOfMoney.h"

@interface IDPaymentContext : NSObject

@property (strong, nonatomic) IDPaymentAmountOfMoney *amountOfMoney;
@property (nonatomic, readonly) BOOL isRecurring;
@property (strong, nonatomic, readonly) NSString *countryCode;
@property (strong, nonatomic) NSString *locale;
@property (assign, nonatomic) BOOL forceBasicFlow;

- (instancetype)initWithAmountOfMoney:(IDPaymentAmountOfMoney *)amountOfMoney isRecurring:(BOOL)isRecurring countryCode:(NSString *)countryCode;

@end
