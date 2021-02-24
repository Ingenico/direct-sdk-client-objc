//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDAccountsOnFile.h"
#import "IDPaymentItemDisplayHints.h"
#import "IDBasicPaymentProductGroup.h"
#import "IDBasicPaymentProductGroupConverter.h"

@interface IDBasicPaymentGroupConverterTestCase : XCTestCase

@property (strong, nonatomic) IDBasicPaymentProductGroupConverter *converter;

@end

@implementation IDBasicPaymentGroupConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [IDBasicPaymentProductGroupConverter new];
}

- (void)testBasicPaymentProductGroupFromJSON {
    NSString *paymentProductGroupPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroup" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupData = [fileManager contentsAtPath:paymentProductGroupPath];
    NSDictionary *paymentProductGroupJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupData options:0 error:NULL];
    IDBasicPaymentProductGroup *paymentProductGroup = [self.converter paymentProductGroupFromJSON:paymentProductGroupJSON];
    XCTAssertTrue([paymentProductGroup.identifier isEqualToString:@"card"] == YES, @"Payment product has an unexpected identifier");
    XCTAssertNotNil(paymentProductGroup.displayHints.logoPath, @"Display hints of payment product has no logo path");
    XCTAssertTrue(paymentProductGroup.accountsOnFile.accountsOnFile.count == 0, @"Unexpected number of accounts on file");
}

@end
