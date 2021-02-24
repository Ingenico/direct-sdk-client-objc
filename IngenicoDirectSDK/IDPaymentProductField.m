//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentProductField.h"
#import "IDValidator.h"
#import "IDValidationErrorIsRequired.h"
#import "IDValidationErrorInteger.h"
#import "IDValidationErrorNumericString.h"

@interface IDPaymentProductField ()

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) NSRegularExpression *numericStringCheck;

@end

@implementation IDPaymentProductField

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.dataRestrictions = [[IDDataRestrictions alloc] init];
        self.displayHints = [[IDPaymentProductFieldDisplayHints alloc] init];
        self.errors = [[NSMutableArray alloc] init];
        self.numericStringCheck = [[NSRegularExpression alloc] initWithPattern:@"^\\d+$" options:0 error:nil];
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}

- (void)validateValue:(NSString *)value
{
    NSLog(@"validateValue: is deprecated! please use validateValue:forPaymentRequest: instead");
    [self validateValue:value forPaymentRequest:nil];
}

- (void)validateValue:(NSString *)value forPaymentRequest:(IDPaymentRequest *)request
{
    [self.errors removeAllObjects];
    if (self.dataRestrictions.isRequired == YES && [value isEqualToString:@""] == YES) {
        IDValidationErrorIsRequired *error = [[IDValidationErrorIsRequired alloc] init];
        [self.errors addObject:error];
    } else if (self.dataRestrictions.isRequired == YES || [value isEqualToString:@""] == NO || self.dataRestrictions.validators.containsSomeTimesRequiredValidator) {
        for (IDValidator *rule in self.dataRestrictions.validators.validators) {
            [rule validate:value forPaymentRequest:request];
            [self.errors addObjectsFromArray:rule.errors];
        }
        switch (self.type) {
            case IDExpirationDate:
                break;
            case IDInteger: {
                NSNumber *number = [self.numberFormatter numberFromString:value];
                if (number == nil) {
                    IDValidationErrorInteger *error = [[IDValidationErrorInteger alloc] init];
                    [self.errors addObject:error];
                }
                break;
            }
            case IDNumericString: {
                if ([self.numericStringCheck numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)] != 1) {
                    IDValidationErrorNumericString *error = [[IDValidationErrorNumericString alloc] init];
                    [self.errors addObject:error];
                }
                break;
            }
            case IDString:
                break;
            case IDBooleanString:
                break;
            case IDDateString:
                break;
            default:
                [NSException raise:@"Invalid type" format:@"Type %u is invalid", self.type];
                break;
        }
    }
}

@end
