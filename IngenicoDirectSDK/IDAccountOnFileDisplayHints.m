//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDAccountOnFileDisplayHints.h"

@implementation IDAccountOnFileDisplayHints

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.labelTemplate = [[IDLabelTemplate alloc] init];
    }
    return self;
}

@end
