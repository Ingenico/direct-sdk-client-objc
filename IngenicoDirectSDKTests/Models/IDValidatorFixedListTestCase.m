//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDValidatorFixedList.h"

@interface IDValidatorFixedListTestCase : XCTestCase

@property (strong, nonatomic) IDValidatorFixedList *validator;

@end

@implementation IDValidatorFixedListTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[IDValidatorFixedList alloc] initWithAllowedValues:@[@"1"]];
}

- (void)testValidateCorrect
{
    [self.validator validate:@"1" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect
{
    [self.validator validate:@"X" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
