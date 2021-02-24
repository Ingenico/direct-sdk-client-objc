//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentProductFields.h"
#import "IDPaymentProductField.h"

@implementation IDPaymentProductFields

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProductFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)sort
{
    [self.paymentProductFields sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IDPaymentProductField *field1 = (IDPaymentProductField *)obj1;
        IDPaymentProductField *field2 = (IDPaymentProductField *)obj2;
        if (field1.displayHints.displayOrder > field2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (field1.displayHints.displayOrder < field2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
