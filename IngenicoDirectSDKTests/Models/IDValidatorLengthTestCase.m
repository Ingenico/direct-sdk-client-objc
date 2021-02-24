//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "IDValidatorLength.h"

@interface IDValidatorLengthTestCase : XCTestCase

@property (strong, nonatomic) IDValidatorLength *validator;

@end

@implementation IDValidatorLengthTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[IDValidatorLength alloc] init];
    self.validator.maxLength = 3;
    self.validator.minLength = 1;
}

- (void)testValidateCorrect1
{
    [self.validator validate:@"1" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateCorrect2
{
    [self.validator validate:@"12" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateCorrect3
{
    [self.validator validate:@"123"];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect1
{
    [self.validator validate:@""];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

- (void)testValidateIncorrect2
{
    [self.validator validate:@"1234"];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
