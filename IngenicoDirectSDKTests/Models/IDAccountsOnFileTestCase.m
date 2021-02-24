//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDAccountsOnFile.h"
#import "IDAccountOnFile.h"

@interface IDAccountsOnFileTestCase : XCTestCase

@property (strong, nonatomic) IDAccountsOnFile *accountsOnFile;
@property (strong, nonatomic) IDAccountOnFile *account1;
@property (strong, nonatomic) IDAccountOnFile *account2;

@end

@implementation IDAccountsOnFileTestCase

- (void)setUp
{
    [super setUp];
    self.accountsOnFile = [[IDAccountsOnFile alloc] init];
    self.account1 = [[IDAccountOnFile alloc] init];
    self.account1.identifier = @"1";
    self.account2 = [[IDAccountOnFile alloc] init];
    self.account2.identifier = @"2";
    [self.accountsOnFile.accountsOnFile addObject:self.account1];
    [self.accountsOnFile.accountsOnFile addObject:self.account2];
}

- (void)testAccountOnFileWithIdentifier
{
    XCTAssertEqual([self.accountsOnFile accountOnFileWithIdentifier:@"1"], self.account1, @"Incorrect account on file retrieved");
}

@end
