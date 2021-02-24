//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "IDNetworkingWrapper.h"
#import "IDEnvironment.h"
#import "IDRegion.h"
#import "IDUtil.h"

@interface IDNetworkingWrapperTestCase : XCTestCase

@property (strong, nonatomic) IDNetworkingWrapper *wrapper;
@property (nonatomic) IDRegion region;
@property (nonatomic) IDEnvironment environment;
@property (strong, nonatomic) IDUtil *util;

@end

@implementation IDNetworkingWrapperTestCase

- (void)setUp
{
    [super setUp];
    
    self.util = [[IDUtil alloc] init];
    self.wrapper = [[IDNetworkingWrapper alloc] init];
    
    // The following value must be updated to reflect your situation for this test to succeed.
    self.environment = IDSandbox;
    self.region = IDRegionEU;
}

- (void)ignore_testPost
{
    NSString *baseURL = [self.util C2SBaseURLByRegion:self.region environment:self.environment];
    NSString *merchantId = @"1234";
    NSString *sessionsURL = [NSString stringWithFormat:@"%@/%@/sessions", baseURL, merchantId];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response provided"];
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:401];
    [self.wrapper postResponseForURL:sessionsURL headers:nil withParameters:nil additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
        [self assertErrorResponse:(NSDictionary *)responseObject expectation:expectation];
    } failure:^(NSError *error) {
        XCTFail(@"Unexpected failure while testing POST request: %@", [error localizedDescription]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", [error localizedDescription]);
        }
    }];
}

- (void)ignore_testGet
{
    NSString *baseURL = [self.util C2SBaseURLByRegion:self.region environment:self.environment];
    NSString *customerId = @"1234";
    NSString *publicKeyURL = [NSString stringWithFormat:@"%@/%@/crypto/publickey", baseURL, customerId];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response provided"];
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:401];
    [self.wrapper getResponseForURL:publicKeyURL headers:nil additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
        [self assertErrorResponse:(NSDictionary *)responseObject expectation:expectation];
    } failure:^(NSError *error) {
        XCTFail(@"Unexpected failure while testing GET request: %@", [error localizedDescription]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", [error localizedDescription]);
        }
    }];
}

- (void)assertErrorResponse:(NSDictionary *)errorResponse expectation:(XCTestExpectation *)expectation
{
    NSArray *errors = (NSArray *)[errorResponse objectForKey:@"errors"];
    NSDictionary *firstError = [errors objectAtIndex:0];
    XCTAssertEqual([[firstError objectForKey:@"code"] integerValue], 9002);
    XCTAssertTrue([[firstError objectForKey:@"message"] isEqualToString:@"MISSING_OR_INVALID_AUTHORIZATION"]);
    [expectation fulfill];
}

@end
