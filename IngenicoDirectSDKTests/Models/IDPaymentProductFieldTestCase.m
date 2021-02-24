//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDPaymentProductField.h"
#import "IDValidatorLength.h"
#import "IDValidatorRange.h"

@interface IDPaymentProductFieldTestCase : XCTestCase

@property (strong, nonatomic) IDPaymentProductField *field;

@end

@implementation IDPaymentProductFieldTestCase

- (void)setUp
{
    [super setUp];
    self.field = [[IDPaymentProductField alloc] init];
    IDValidatorLength *length = [[IDValidatorLength alloc] init];
    length.minLength = 4;
    length.maxLength = 6;
    IDValidatorRange *range = [[IDValidatorRange alloc] init];
    range.minValue = 50;
    range.maxValue = 60;
    [self.field.dataRestrictions.validators.validators addObject:length];
    [self.field.dataRestrictions.validators.validators addObject:range];
}

- (void)testValidateValueCorrect
{
    [self.field validateValue:@"0055"];
    XCTAssertTrue(self.field.errors.count == 0, @"Unexpected errors after validation");
}

- (void)testValidateValueIncorrect
{
    [self.field validateValue:@"0"];
    XCTAssertTrue(self.field.errors.count == 2, @"Unexpected number of errors after validation");
}

@end
