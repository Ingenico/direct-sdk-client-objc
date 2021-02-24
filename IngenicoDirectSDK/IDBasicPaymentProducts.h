//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "IDBasicPaymentProduct.h"

@interface IDBasicPaymentProducts : NSObject

@property (strong, nonatomic) NSMutableArray *paymentProducts;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (IDBasicPaymentProduct *)paymentProductWithIdentifier:(NSString *)paymentProductIdentifier;
- (void)sort;
- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;

@end
