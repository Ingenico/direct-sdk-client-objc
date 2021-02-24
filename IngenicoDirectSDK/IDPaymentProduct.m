//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentProduct.h"

@implementation IDPaymentProduct

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.fields = [[IDPaymentProductFields alloc] init];
    }
    return self;
}

- (IDPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId
{
    for (IDPaymentProductField *field in self.fields.paymentProductFields) {
        if ([field.identifier isEqualToString:paymentProductFieldId] == YES) {
            return field;
        }
    }
    return nil;
}

@end
