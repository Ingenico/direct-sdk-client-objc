//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>

#import "IDC2SCommunicatorConfiguration.h"
#import "IDStubUtil.h"

@interface IDC2SCommunicatorConfigurationTestCase : XCTestCase

@property (strong, nonatomic)IDC2SCommunicatorConfiguration *configuration;
@property (strong, nonatomic)IDStubUtil *util;

@end

@implementation IDC2SCommunicatorConfigurationTestCase

- (void)setUp
{
    [super setUp];
    self.util = [[IDStubUtil alloc] init];
    self.configuration = [[IDC2SCommunicatorConfiguration alloc] initWithClientSessionId:@"" customerId:@"" region:IDRegionEU environment:IDSandbox util:self.util];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBaseURL
{
    XCTAssertTrue([[self.configuration baseURL] isEqualToString:@"c2sbaseurlbyregion"] == YES, @"Unexpected base URL");
}

- (void)testAssetsBaseURL
{
    XCTAssertTrue([[self.configuration assetsBaseURL] isEqualToString:@"assetsbaseurlbyregion"] == YES, @"Unexpected assets base URL");
}

- (void)testBase64EncodedClientMetaInfo
{
    XCTAssertTrue([[self.configuration base64EncodedClientMetaInfo] isEqualToString:@"base64encodedclientmetainfo"] == YES, @"Unexpected encoded client meta info");
}

@end
