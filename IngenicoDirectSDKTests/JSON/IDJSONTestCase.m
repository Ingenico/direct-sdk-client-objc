//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDJSON.h"

@interface IDJSONTestCase : XCTestCase

@property (strong, nonatomic) IDJSON *JSON;

@end

@implementation IDJSONTestCase

- (void)setUp
{
    [super setUp];
    self.JSON = [[IDJSON alloc] init];
}

- (void)testDictionary
{
    NSDictionary *input = @{@"firstName": @"John", @"lastName": @"Doe"};
    NSDictionary *firstPair = @{@"key": @"firstName", @"value": @"John"};
    NSDictionary *secondPair = @{@"key": @"lastName", @"value": @"Doe"};
    NSArray *firstOutput = @[firstPair, secondPair];
    NSArray *secondOutput = @[secondPair, firstPair];
    NSData *firstData = [NSJSONSerialization dataWithJSONObject:firstOutput options:0 error:NULL];
    NSData *secondData = [NSJSONSerialization dataWithJSONObject:secondOutput options:0 error:NULL];
    NSString *firstExpectedOutput = [[NSString alloc] initWithData:firstData encoding:NSUTF8StringEncoding];
    NSString *secondExpectedOutput = [[NSString alloc] initWithData:secondData encoding:NSUTF8StringEncoding];
    NSString *actualOutput = [self.JSON keyValueJSONFromDictionary:input];
    XCTAssertTrue([firstExpectedOutput isEqualToString:actualOutput] || [secondExpectedOutput isEqualToString:actualOutput], @"Generated JSON differs from manually constructed JSON");
}

@end
