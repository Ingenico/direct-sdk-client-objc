//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "IDBasicPaymentItemConverter.h"

@protocol IDPaymentItem;

@interface IDPaymentItemConverter : IDBasicPaymentItemConverter

- (void)setPaymentItem:(NSObject <IDPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem;
- (void)setPaymentProductFields:(IDPaymentProductFields *)fields JSON:(NSArray *)rawFields;

@end
