//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "IDBasicPaymentProduct.h"
#import  "IDAssetManager.h"
#import  "IDStringFormatter.h"
#import  "IDBasicPaymentItemConverter.h"

@interface IDBasicPaymentProductConverter : IDBasicPaymentItemConverter

- (IDBasicPaymentProduct *)basicPaymentProductFromJSON:(NSDictionary *)rawBasicProduct;
- (void)setBasicPaymentProduct:(IDBasicPaymentProduct *)basicProduct JSON:(NSDictionary *)rawBasicProduct;

@end
