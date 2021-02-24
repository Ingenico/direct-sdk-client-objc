//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDValidatorEmailAddress.h"
#import "IDValidationErrorEmailAddress.h"

@interface IDValidatorEmailAddress ()

@property (strong, nonatomic) NSRegularExpression *expression;

@end

@implementation IDValidatorEmailAddress

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        NSError *error = nil;
        NSString *regex = @"^[^@\\.]+(\\.[^@\\.]+)*@([^@\\.]+\\.)*[^@\\.]+\\.[^@\\.][^@\\.]+$";
        self.expression = [[NSRegularExpression alloc] initWithPattern:regex options:0 error:&error];
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSInteger numberOfMatches = [self.expression numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
    if (numberOfMatches != 1) {
        IDValidationErrorEmailAddress *error = [[IDValidationErrorEmailAddress alloc] init];
        [self.errors addObject:error];
    }
}

@end
