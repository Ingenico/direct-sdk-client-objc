//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDAccountOnFileAttributes.h"
#import "IDAccountOnFileAttribute.h"

@implementation IDAccountOnFileAttributes

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.attributes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)valueForField:(NSString *)paymentProductFieldId
{
    for (IDAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return attribute.value;
        }
    }
    return @"";
}

- (BOOL)hasValueForField:(NSString *)paymentProductFieldId
{
    for (IDAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId
{
    for (IDAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return attribute.status == IDReadOnly;
        }
    }
    return NO;
}

@end
