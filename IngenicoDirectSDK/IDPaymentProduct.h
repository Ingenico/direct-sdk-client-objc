//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDBasicPaymentProduct.h"
#import "IDPaymentProductFields.h"
#import "IDPaymentProductField.h"

@interface IDPaymentProduct : IDBasicPaymentProduct <IDPaymentItem>

@property (strong, nonatomic) IDPaymentProductFields *fields;

- (IDPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId;

@end
