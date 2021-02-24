//
//  IDValidatorLuhnTestCase.m
//  IngenicoConnectSDK
//
//  Created for Ingenico ePayments on 15/12/2016.
//  Copyright © 2017 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDValidatorLuhn.h"

@interface IDValidatorLuhnTestCase : XCTestCase

@property (strong, nonatomic) IDValidatorLuhn *validator;

@end

@implementation IDValidatorLuhnTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[IDValidatorLuhn alloc] init];
}

- (void)testValidateCorrect
{
    [self.validator validate:@"4242424242424242" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect
{
    [self.validator validate:@"1111" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
