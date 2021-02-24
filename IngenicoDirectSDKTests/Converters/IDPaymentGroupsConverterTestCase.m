//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDPaymentItemDisplayHints.h"
#import "IDBasicPaymentProductGroup.h"
#import "IDPaymentProductGroupsConverter.h"
#import "IDBasicPaymentProductGroups.h"

@interface IDPaymentGroupsConverterTestCase : XCTestCase

@property (nonatomic, strong) IDPaymentProductGroupsConverter *converter;

@end

@implementation IDPaymentGroupsConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [IDPaymentProductGroupsConverter new];
}

- (void)testPaymentProductGroupsFromJSON {
    NSString *paymentProductGroupsPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroups" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupsData = [fileManager contentsAtPath:paymentProductGroupsPath];
    NSDictionary *paymentProductGroupsJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupsData options:0 error:NULL];
    IDBasicPaymentProductGroups *paymentProductGroups = [self.converter paymentProductGroupsFromJSON:paymentProductGroupsJSON[@"paymentProductGroups"]];
    if (paymentProductGroups.paymentProductGroups.count != 1) {
        XCTFail(@"Wrong number of payment products.");
    }
    for (IDBasicPaymentProductGroup *product in paymentProductGroups.paymentProductGroups) {
        XCTAssertNotNil(product.identifier, @"Payment product has no identifier");
        XCTAssertNotNil(product.displayHints, @"Payment product has no displayHints");
        XCTAssertNotNil(product.displayHints.logoPath, @"Payment product has no logo path in displayHints");
    }
}

@end
