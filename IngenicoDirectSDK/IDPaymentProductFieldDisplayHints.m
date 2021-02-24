//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentProductFieldDisplayHints.h"

@implementation IDPaymentProductFieldDisplayHints

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.formElement = [[IDFormElement alloc] init];
        self.tooltip = [[IDTooltip alloc] init];
    }
    return self;
}

@end
