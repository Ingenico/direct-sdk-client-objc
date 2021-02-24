//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDStringFormatter;
@class IDBasicPaymentProductGroup;

@interface IDBasicPaymentProductGroups : NSObject

@property (nonatomic, strong) NSMutableArray *paymentProductGroups;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (IDBasicPaymentProductGroup *)paymentProductGroupWithIdentifier:(NSString *)paymentProductGroupIdentifier;
- (void)sort;
- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;

@end
