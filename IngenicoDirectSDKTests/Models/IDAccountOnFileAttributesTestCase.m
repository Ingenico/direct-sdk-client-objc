//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "IDAccountOnFileAttributes.h"
#import "IDAccountOnFileAttribute.h"

@interface IDAccountOnFileAttributesTestCase : XCTestCase

@property (strong, nonatomic) IDAccountOnFileAttributes *attributes;

@end

@implementation IDAccountOnFileAttributesTestCase

- (void)setUp
{
    [super setUp];
    self.attributes = [[IDAccountOnFileAttributes alloc] init];
    IDAccountOnFileAttribute *attribute1 = [[IDAccountOnFileAttribute alloc] init];
    attribute1.key = @"key1";
    attribute1.value = @"value1";
    IDAccountOnFileAttribute *attribute2 = [[IDAccountOnFileAttribute alloc] init];
    attribute2.key = @"key2";
    attribute2.value = @"value2";
    [self.attributes.attributes addObject:attribute1];
    [self.attributes.attributes addObject:attribute2];
}

- (void)testValueForField
{
    XCTAssertTrue([[self.attributes valueForField:@"key1"] isEqualToString:@"value1"] == YES, @"Incorrect value for key");
}

- (void)testHasValueForFieldYes
{
    XCTAssertTrue([self.attributes hasValueForField:@"key1"] == YES, @"Attributes should have a value for this key");
}

- (void)testHasValueForFieldNo
{
    XCTAssertTrue([self.attributes hasValueForField:@"key3"] == NO, @"Attributes should not have a value for this key");
}

@end
