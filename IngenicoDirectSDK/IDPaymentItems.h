//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDStringFormatter;
@protocol IDBasicPaymentItem;
@class IDBasicPaymentProducts;
@class IDBasicPaymentProductGroups;

@interface IDPaymentItems : NSObject

@property (nonatomic, strong) NSMutableArray *paymentItems;

- (instancetype)initWithPaymentProducts:(IDBasicPaymentProducts *)products groups:(IDBasicPaymentProductGroups *)groups;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (NSObject<IDBasicPaymentItem> *)paymentItemWithIdentifier:(NSString *)paymentItemIdentifier;
- (void)sort;

@end
