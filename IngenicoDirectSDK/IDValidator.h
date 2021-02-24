//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

@class IDPaymentRequest;

@interface IDValidator : NSObject

@property (strong, nonatomic) NSMutableArray *errors;

- (void)validate:(NSString *)value DEPRECATED_ATTRIBUTE;
- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request;

@end
