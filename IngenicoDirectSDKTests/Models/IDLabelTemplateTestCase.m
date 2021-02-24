//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDLabelTemplate.h"
#import "IDLabelTemplateItem.h"

@interface IDLabelTemplateTestCase : XCTestCase

@property (strong, nonatomic) IDLabelTemplate *template;

@end

@implementation IDLabelTemplateTestCase

- (void)setUp
{
    [super setUp];
    self.template = [[IDLabelTemplate alloc] init];
    IDLabelTemplateItem *item1 = [[IDLabelTemplateItem alloc] init];
    item1.attributeKey = @"key1";
    item1.mask = @"mask1";
    IDLabelTemplateItem *item2 = [[IDLabelTemplateItem alloc] init];
    item2.attributeKey = @"key2";
    item2.mask = @"mask2";
    [self.template.labelTemplateItems addObject:item1];
    [self.template.labelTemplateItems addObject:item2];
    
}

- (void)testMaskForAttributeKey
{
    NSString *mask = [self.template maskForAttributeKey:@"key1"];
    XCTAssertTrue([mask isEqualToString:@"mask1"] == YES, @"Unexpected mask encountered");
}

@end
