//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPaymentItem.h"

@class IDStringFormatter;
@class IDAccountOnFile;
@class IDPaymentProductField;

@interface IDPaymentProductGroup : NSObject <IDPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) IDPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) IDAccountsOnFile *accountsOnFile;
@property (nonatomic) BOOL allowsTokenization;
@property (nonatomic) BOOL allowsRecurring;
@property (strong, nonatomic) IDPaymentProductFields *fields;

- (IDAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;
- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;
- (IDPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId;

@end
