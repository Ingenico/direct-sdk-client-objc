//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDValidator.h"
#import "IDPaymentRequest.h"

@implementation IDValidator

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.errors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)validate:(NSString *)value
{
    NSLog(@"validate: is deprecated! please use validate:forPaymentRequest: instead");
    [self validate:value forPaymentRequest:nil];
}

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [self.errors removeAllObjects];
}

@end
