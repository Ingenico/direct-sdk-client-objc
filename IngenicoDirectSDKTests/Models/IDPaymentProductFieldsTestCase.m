//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "IDPaymentPRoductFields.h"
#import "IDPaymentProductField.h"

@interface IDPaymentProductFieldsTestCase : XCTestCase

@property (strong, nonatomic) IDPaymentProductFields *fields;

@end

@implementation IDPaymentProductFieldsTestCase

- (void)setUp
{
    [super setUp];
    self.fields = [[IDPaymentProductFields alloc] init];
    IDPaymentProductField *field1 = [[IDPaymentProductField alloc] init];
    field1.displayHints.displayOrder = 1;
    IDPaymentProductField *field2 = [[IDPaymentProductField alloc] init];
    field2.displayHints.displayOrder = 100;
    IDPaymentProductField *field3 = [[IDPaymentProductField alloc] init];
    field3.displayHints.displayOrder = 4;
    IDPaymentProductField *field4 = [[IDPaymentProductField alloc] init];
    field4.displayHints.displayOrder = 50;
    IDPaymentProductField *field5 = [[IDPaymentProductField alloc] init];
    field5.displayHints.displayOrder = 3;
    [self.fields.paymentProductFields addObject:field1];
    [self.fields.paymentProductFields addObject:field2];
    [self.fields.paymentProductFields addObject:field3];
    [self.fields.paymentProductFields addObject:field4];
    [self.fields.paymentProductFields addObject:field5];
}

- (void)testSort
{
    [self.fields sort];
    NSInteger displayOrder = -1;
    for (IDPaymentProductField *field in self.fields.paymentProductFields) {
        if (displayOrder > field.displayHints.displayOrder) {
            XCTFail(@"Fields not sorted according to display order");
        }
        displayOrder = field.displayHints.displayOrder;
    }
}

@end
