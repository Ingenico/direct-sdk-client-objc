//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentProductGroup.h"
#import "IDPaymentItemDisplayHints.h"
#import "IDAccountsOnFile.h"
#import "IDPaymentProductField.h"
#import "IDPaymentProductFields.h"

@implementation IDPaymentProductGroup

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[IDPaymentItemDisplayHints alloc] init];
        self.accountsOnFile = [[IDAccountsOnFile alloc] init];
        self.fields = [IDPaymentProductFields new];
    }
    return self;
}

- (IDAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier
{
    return [self.accountsOnFile accountOnFileWithIdentifier:accountOnFileIdentifier];
}

- (void)setStringFormatter:(IDStringFormatter *)stringFormatter
{
    for (IDAccountOnFile *accountOnFile in self.accountsOnFile.accountsOnFile) {
        accountOnFile.stringFormatter = stringFormatter;
    }
}

- (IDPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId
{
    for (IDPaymentProductField *field in self.fields.paymentProductFields) {
        if ([field.identifier isEqualToString:paymentProductFieldId] == YES) {
            return field;
        }
    }
    return nil;
}

@end
