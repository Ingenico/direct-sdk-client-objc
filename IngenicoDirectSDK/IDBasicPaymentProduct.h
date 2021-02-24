//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAccountsOnFile.h"
#import "IDAccountOnFile.h"
#import "IDPaymentItemDisplayHints.h"
#import "IDPaymentItem.h"
#import "IDBasicPaymentItem.h"
#import "IDPaymentProduct302SpecificData.h"

@interface IDBasicPaymentProduct : NSObject <IDBasicPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) IDPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) IDAccountsOnFile *accountsOnFile;
@property (nonatomic) BOOL allowsTokenization;
@property (nonatomic) BOOL allowsRecurring;

@property (nonatomic) NSString *paymentMethod;
@property (nonatomic) NSString *paymentProductGroup;

@property (strong, nonatomic) IDPaymentProduct302SpecificData *paymentProduct302SpecificData;

- (IDAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;
- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;

@end
