//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDBasicPaymentProductsConverter.h"
#import  "IDBasicPaymentProductConverter.h"

@implementation IDBasicPaymentProductsConverter

- (IDBasicPaymentProducts *)paymentProductsFromJSON:(NSArray *)rawProducts
{
    IDBasicPaymentProducts *products = [[IDBasicPaymentProducts alloc] init];
    IDBasicPaymentProductConverter *converter = [[IDBasicPaymentProductConverter alloc] init];
    for (NSDictionary *rawProduct in rawProducts) {
        IDBasicPaymentProduct *product = [converter basicPaymentProductFromJSON:rawProduct];
        [products.paymentProducts addObject:product];
    }
    [products sort];
    return products;
}

@end
