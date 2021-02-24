//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDValidatorRegularExpression.h"

@interface IDValidatorRegularExpressionTestCase : XCTestCase

@property (strong, nonatomic) IDValidatorRegularExpression *validator;

@end

@implementation IDValidatorRegularExpressionTestCase

- (void)setUp
{
    [super setUp];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\d{3}" options:0 error:NULL];
    self.validator = [[IDValidatorRegularExpression alloc] initWithRegularExpression:regularExpression];
}

- (void)testValidateCorrect
{
    [self.validator validate:@"123" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect
{
    [self.validator validate:@"abc" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
