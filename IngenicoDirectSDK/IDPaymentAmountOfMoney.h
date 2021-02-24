//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface IDPaymentAmountOfMoney : NSObject

@property (nonatomic, readonly) long totalAmount;
@property (strong, nonatomic, readonly) NSString *currencyCode;

- (instancetype)initWithTotalAmount:(long)totalAmount currencyCode:(NSString *)currencyCode;

- (NSString *)description;

@end
