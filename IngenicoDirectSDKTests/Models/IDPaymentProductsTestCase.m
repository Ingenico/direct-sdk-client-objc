//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDBasicPaymentProducts.h"

@interface IDPaymentProductsTestCase : XCTestCase

@property (strong, nonatomic) IDBasicPaymentProducts *products;

@end

@implementation IDPaymentProductsTestCase

- (void)setUp
{
    [super setUp];
    self.products = [[IDBasicPaymentProducts alloc] init];
}

- (void)testHasAccountsOnFileTrue
{
    IDAccountOnFile *account = [[IDAccountOnFile alloc] init];
    IDBasicPaymentProduct *product = [[IDBasicPaymentProduct alloc] init];
    [product.accountsOnFile.accountsOnFile addObject:account];
    [self.products.paymentProducts addObject:product];
    XCTAssertTrue([self.products hasAccountsOnFile] == YES, @"Payment products should have an account on file");
}

- (void)testHasAccountsOnFileFalse
{
    XCTAssertTrue([self.products hasAccountsOnFile] == NO, @"Payment products should not have an account on file");
}

- (void)testAccountsOnFile
{
    IDAccountOnFile *account = [[IDAccountOnFile alloc] init];
    IDBasicPaymentProduct *product = [[IDBasicPaymentProduct alloc] init];
    [product.accountsOnFile.accountsOnFile addObject:account];
    [self.products.paymentProducts addObject:product];
    NSArray *accountsOnFile = self.products.accountsOnFile;
    XCTAssertTrue(accountsOnFile.count == 1, @"Unexpected number of accounts on file");
    XCTAssertTrue(accountsOnFile[0] == account, @"Account on file that was added is not returned");
}

- (void)testPaymentProductWithIdentifierExisting
{
    IDBasicPaymentProduct *product = [[IDBasicPaymentProduct alloc] init];
    product.identifier = @"1";
    [self.products.paymentProducts addObject:product];
    XCTAssertTrue([self.products paymentProductWithIdentifier:@"1"] == product, @"Unexpected payment product retrieved");
}

- (void)testPaymentProductWithIdentifierNonExisting
{
    IDBasicPaymentProduct *product = [[IDBasicPaymentProduct alloc] init];
    product.identifier = @"1";
    [self.products.paymentProducts addObject:product];
    XCTAssertTrue([self.products paymentProductWithIdentifier:@"X"] == nil, @"Retrieved a payment product that has not been added");
}

- (void)testSort
{
    IDBasicPaymentProduct *product1 = [[IDBasicPaymentProduct alloc] init];
    product1.displayHints.displayOrder = 100;
    [self.products.paymentProducts addObject:product1];
    IDBasicPaymentProduct *product2 = [[IDBasicPaymentProduct alloc] init];
    product2.displayHints.displayOrder = 10;
    [self.products.paymentProducts addObject:product2];
    IDBasicPaymentProduct *product3 = [[IDBasicPaymentProduct alloc] init];
    product3.displayHints.displayOrder = 99;
    [self.products.paymentProducts addObject:product3];
    [self.products sort];
    NSUInteger displayOrder = 0;
    for (int i = 0; i < 3; ++i) {
        IDBasicPaymentProduct *product = self.products.paymentProducts[i];
        if (displayOrder > product.displayHints.displayOrder) {
            XCTFail(@"Products are not sorted");
        }
        displayOrder = product.displayHints.displayOrder;
    }
}

@end
