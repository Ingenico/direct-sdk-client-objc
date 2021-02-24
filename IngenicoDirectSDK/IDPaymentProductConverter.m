//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDPaymentProductConverter.h"

@implementation IDPaymentProductConverter

- (IDPaymentProduct *)paymentProductFromJSON:(NSDictionary *)rawProduct
{
    IDPaymentProduct *product = [[IDPaymentProduct alloc] init];
    [super setBasicPaymentProduct:product JSON:rawProduct];

    IDPaymentItemConverter *itemConverter = [IDPaymentItemConverter new];
    [itemConverter setPaymentProductFields:product.fields JSON:[rawProduct objectForKey:@"fields"]];
    return product;
}

@end
