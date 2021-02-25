//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDBasicPaymentProductsConverter.h"

@interface IDPaymentProductsConverterTestCase : XCTestCase

@property (strong, nonatomic) IDBasicPaymentProductsConverter *converter;

@end

@implementation IDPaymentProductsConverterTestCase

- (void)setUp
{
    [super setUp];
    self.converter = [[IDBasicPaymentProductsConverter alloc] init];
}

- (void)testPaymentProductsFromJSON
{
    NSString *paymentProductsPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProducts" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductsData = [fileManager contentsAtPath:paymentProductsPath];
    NSDictionary *paymentProductsJSON = [NSJSONSerialization JSONObjectWithData:paymentProductsData options:0 error:NULL];
    IDBasicPaymentProducts *paymentProducts = [self.converter paymentProductsFromJSON:[paymentProductsJSON objectForKey:@"paymentProducts"]];
    if (paymentProducts.paymentProducts.count != 24) {
        XCTFail(@"Wrong number of payment products.");
    }
    for (IDBasicPaymentProduct *product in paymentProducts.paymentProducts) {
        XCTAssertNotNil(product.identifier, @"Payment product has no identifier");
        XCTAssertNotNil(product.displayHints, @"Payment product has no displayHints");
        XCTAssertNotNil(product.displayHints.logoPath, @"Payment product has no logo path in displayHints");
        if (product.accountsOnFile != nil) {
            for (IDAccountOnFile *accountOnFile in product.accountsOnFile.accountsOnFile) {
                XCTAssertNotNil(accountOnFile.attributes, @"Account on file has no attributes");
                XCTAssertNotNil(accountOnFile.displayHints, @"Account on file has no displayHints");
            }
        }
    }
}

@end
