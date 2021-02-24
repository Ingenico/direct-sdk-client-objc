//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>

#import "IDUtil.h"
#import "IDBase64.h"

@interface IDUtilTestCase : XCTestCase

@property (strong, nonatomic) IDUtil *util;
@property (strong, nonatomic) IDBase64 *base64;

@end

@implementation IDUtilTestCase

- (void)setUp
{
    [super setUp];
    self.util = [[IDUtil alloc] init];
    self.base64 = [[IDBase64 alloc] init];
}

- (void)testBase64EncodedClientMetaInfo;
{
    NSString *info = [self.util base64EncodedClientMetaInfo];
    NSData *decodedInfo = [self.base64 decode:info];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:decodedInfo options:0 error:NULL];
    XCTAssertTrue([[JSON objectForKey:@"deviceBrand"] isEqualToString:@"Apple"] == YES, @"Incorrect device brand in meta info");
}

- (void)testBase64EncodedClientMetaInfoWithAddedData;
{
    NSString *info = [self.util base64EncodedClientMetaInfoWithAddedData:@{@"test": @"value"}];
    NSData *decodedInfo = [self.base64 decode:info];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:decodedInfo options:0 error:NULL];
    XCTAssertTrue([[JSON objectForKey:@"test"] isEqualToString:@"value"] == YES, @"Incorrect value for added key in meta info");
}

@end
