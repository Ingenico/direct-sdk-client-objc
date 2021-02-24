//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDAccountsOnFile.h"

@implementation IDAccountsOnFile

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.accountsOnFile = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IDAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier
{
    for (IDAccountOnFile *accountOnFile in self.accountsOnFile) {
        if ([accountOnFile.identifier isEqualToString:accountOnFileIdentifier] == YES) {
            return accountOnFile;
        }
    }
    return nil;
}

@end
