//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "IDAccountOnFile.h"
#import "IDPaymentProductConverter.h"

@interface IDAccountOnFileTestCase : XCTestCase

@property (strong, nonatomic) IDAccountOnFile *accountOnFile;
@property (strong, nonatomic) IDPaymentProductConverter *converter;
@property (strong, nonatomic) IDStringFormatter *stringFormatter;

@end

@implementation IDAccountOnFileTestCase

- (void)setUp
{
    [super setUp];
    self.accountOnFile = [[IDAccountOnFile alloc] init];
    self.converter = [[IDPaymentProductConverter alloc] init];
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    IDPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    self.accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
    self.stringFormatter = [[IDStringFormatter alloc] init];
    self.accountOnFile.stringFormatter = self.stringFormatter;
}

- (void)testMaskedValueForField
{
    NSString *value = [self.accountOnFile maskedValueForField:@"cardNumber"];
    XCTAssertTrue([value isEqualToString:@"**** **** **** 7988 "] == YES, @"Card number of account on file is incorrect");
}

- (void)testMaskedValueForFieldWithMask
{
    NSString *value = [self.accountOnFile maskedValueForField:@"expiryDate" mask:@"{{99}}   {{99}}"];
    XCTAssertTrue([value isEqualToString:@"08   20"] == YES, @"Expiry date of account on file is incorrect");
}

- (void)testHasValueForFieldYes
{
    XCTAssertTrue([self.accountOnFile hasValueForField:@"expiryDate"] == YES, @"Account on file has no value for expiry date");
}

- (void)testHasValueForFieldNo
{
    XCTAssertTrue([self.accountOnFile hasValueForField:@"cvv"] == NO, @"Account on file has a value for cvv");
}

- (void)testLabel
{
    NSString *actualLabel = [self.accountOnFile label];
    NSString *expectedLabel = @"**** **** **** 7988 Rob";
    XCTAssertTrue([actualLabel isEqualToString:expectedLabel] == YES);
}

@end
