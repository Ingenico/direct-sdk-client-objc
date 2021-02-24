//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDBasicPaymentProductConverter.h"

@implementation IDBasicPaymentProductConverter

- (IDBasicPaymentProduct *)basicPaymentProductFromJSON:(NSDictionary *)rawBasicProduct
{
    IDBasicPaymentProduct *basicProduct = [[IDBasicPaymentProduct alloc] init];
    [self setBasicPaymentProduct:basicProduct JSON:rawBasicProduct];
    return basicProduct;
}

- (void)setBasicPaymentProduct:(IDBasicPaymentProduct *)basicProduct JSON:(NSDictionary *)rawBasicProduct
{
    [super setBasicPaymentItem:basicProduct JSON:rawBasicProduct];
    basicProduct.allowsRecurring = [[rawBasicProduct objectForKey:@"allowsRecurring"] boolValue];
    basicProduct.allowsTokenization = [[rawBasicProduct objectForKey:@"allowsTokenization"] boolValue];
    basicProduct.paymentMethod = [rawBasicProduct objectForKey:@"paymentMethod"];
    basicProduct.paymentProductGroup = [rawBasicProduct objectForKey:@"paymentProductGroup"];

    if (rawBasicProduct[@"paymentProduct302SpecificData"] != nil) {
        IDPaymentProduct302SpecificData *paymentProduct302SpecificData = [[IDPaymentProduct302SpecificData alloc] init];
        [self setPaymentProduct302SpecificData:paymentProduct302SpecificData JSON:[rawBasicProduct objectForKey:@"paymentProduct302SpecificData"]];
        basicProduct.paymentProduct302SpecificData = paymentProduct302SpecificData;
    }
}

- (void)setPaymentProduct302SpecificData:(IDPaymentProduct302SpecificData *)paymentProduct302SpecificData JSON:(NSDictionary *)rawPaymentProduct302SpecificData
{
    NSArray *rawNetworks = [rawPaymentProduct302SpecificData objectForKey:@"networks"];
    for (NSString *network in rawNetworks) {
        [paymentProduct302SpecificData.networks addObject:network];
    }
}

@end
