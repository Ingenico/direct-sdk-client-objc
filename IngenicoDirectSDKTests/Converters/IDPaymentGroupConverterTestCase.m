//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDPaymentProductGroup.h"
#import "IDPaymentProductGroupConverter.h"
#import "IDPaymentProductFields.h"
#import "IDPaymentProductField.h"

@interface IDPaymentGroupConverterTestCase : XCTestCase

@property (strong, nonatomic) IDPaymentProductGroupConverter *converter;

@end

@implementation IDPaymentGroupConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [IDPaymentProductGroupConverter new];
}

- (void)testPaymentProductGroupFromJSON
{
    NSString *paymentProductGroupPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroup" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupData = [fileManager contentsAtPath:paymentProductGroupPath];
    NSDictionary *paymentProductGroupJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupData options:0 error:NULL];
    IDPaymentProductGroup *paymentProductGroup = [self.converter paymentProductGroupFromJSON:paymentProductGroupJSON];
    XCTAssertTrue(paymentProductGroup.fields.paymentProductFields.count == 3, @"Unexpected number of fields");
    IDPaymentProductField *field = paymentProductGroup.fields.paymentProductFields[0];
    XCTAssertTrue(field.dataRestrictions.isRequired == true, @"Unexpected value for 'isRequired'");
    XCTAssertFalse(field.displayHints.alwaysShow, @"Unexpected value for 'alwaysShow'");
    XCTAssertTrue(field.displayHints.displayOrder == 0, @"Unexpected value for 'displayOrder'");
    XCTAssertTrue(field.displayHints.obfuscate == false, @"Unexpected value for 'obfuscate'");
    XCTAssertTrue([field.identifier isEqualToString:@"cardNumber"] == YES, @"Unexpected identifier");
    XCTAssertTrue(field.dataRestrictions.validators.validators.count == 0, @"Unexpected number of validators");
}

@end
