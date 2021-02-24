//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDBasicPaymentProduct.h"

@interface IDBasicPaymentProduct ()

@property (strong, nonatomic) IDStringFormatter *stringFormatter;

@end

@implementation IDBasicPaymentProduct

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[IDPaymentItemDisplayHints alloc] init];
        self.accountsOnFile = [[IDAccountsOnFile alloc] init];
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

@end
