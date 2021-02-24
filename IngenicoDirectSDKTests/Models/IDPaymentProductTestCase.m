//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDPaymentProduct.h"

@interface IDPaymentProductTestCase : XCTestCase

@property (strong, nonatomic) IDPaymentProduct *paymentProduct;
@property (strong, nonatomic) IDPaymentProductField *field;

@end

@implementation IDPaymentProductTestCase

- (void)setUp
{
    [super setUp];
    self.paymentProduct = [[IDPaymentProduct alloc] init];
    self.field = [[IDPaymentProductField alloc] init];
    self.field.identifier = @"1";
    [self.paymentProduct.fields.paymentProductFields addObject:self.field];
}

- (void)testPaymentProductFieldWithIdExists
{
    IDPaymentProductField *field = [self.paymentProduct paymentProductFieldWithId:@"1"];
    XCTAssertEqual(field, self.field, @"Retrieved field is unequal to added field");
}

- (void)testPaymentProductFieldWithIdNil
{
    IDPaymentProductField *field = [self.paymentProduct paymentProductFieldWithId:@"X"];
    XCTAssertTrue(field == nil, @"Retrieved a field while no field should be returned");
}

@end
