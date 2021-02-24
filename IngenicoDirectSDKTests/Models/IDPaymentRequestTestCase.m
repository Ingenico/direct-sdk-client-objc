//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDPaymentRequest.h"
#import "IDPaymentProductConverter.h"

@interface IDPaymentRequestTestCase : XCTestCase

@property (strong, nonatomic) IDPaymentRequest *request;
@property (strong, nonatomic) IDPaymentProductConverter *converter;
@end

@implementation IDPaymentRequestTestCase

- (void)setUp
{
    [super setUp];
    self.request = [[IDPaymentRequest alloc] init];
    self.converter = [[IDPaymentProductConverter alloc] init];
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    IDPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    self.request.paymentProduct = paymentProduct;
    self.request.accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
}

- (void)testValidate
{
    [self.request setValue:@"1" forField:@"cvv"];
    [self.request validate];
    XCTAssertTrue(self.request.errors.count == 2, @"Unexpected number of errors while validating payment request");
}

- (void)testUnmaskedFieldValues
{
    [self.request setValue:@"123" forField:@"cvv"];
    NSDictionary *values = [self.request unmaskedFieldValues];
    NSString *cvv = [values valueForKey:@"cvv"];
    XCTAssertTrue([cvv isEqualToString:@"123"] == YES, @"CVV code is incorrect");
}

@end
