//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPaymentProductFieldDisplayHints.h"
#import "IDDataRestrictions.h"
#import "IDType.h"

@class IDPaymentRequest;

@interface IDPaymentProductField : NSObject

@property (strong, nonatomic) IDDataRestrictions *dataRestrictions;
@property (strong, nonatomic) IDPaymentProductFieldDisplayHints *displayHints;
@property (strong, nonatomic) NSString *identifier;
@property (assign, nonatomic) BOOL usedForLookup;
@property (nonatomic) IDType type;
@property (strong, nonatomic) NSMutableArray *errors;

- (void)validateValue:(NSString *)value DEPRECATED_ATTRIBUTE;
- (void)validateValue:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request;

@end
