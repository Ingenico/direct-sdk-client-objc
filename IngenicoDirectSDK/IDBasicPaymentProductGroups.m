//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDBasicPaymentProductGroups.h"
#import "IDStringFormatter.h"
#import "IDAccountsOnFile.h"
#import "IDPaymentItemDisplayHints.h"
#import "IDBasicPaymentProductGroup.h"

@interface IDBasicPaymentProductGroups ()

@property (strong, nonatomic) IDStringFormatter *stringFormatter;

@end

@implementation IDBasicPaymentProductGroups

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProductGroups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)hasAccountsOnFile
{
    for (IDBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        if (productGroup.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (IDBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        [accountsOnFile addObjectsFromArray:productGroup.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentProductGroup:(NSString *)paymentProductGroupIdentifier
{
    IDBasicPaymentProductGroup *productGroup = [self paymentProductGroupWithIdentifier:paymentProductGroupIdentifier];
    return productGroup.displayHints.logoPath;
}

- (IDBasicPaymentProductGroup *)paymentProductGroupWithIdentifier:(NSString *)paymentProductGroupIdentifier
{
    for (IDBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        if ([productGroup.identifier isEqualToString:paymentProductGroupIdentifier] == YES) {
            return productGroup;
        }
    }
    return nil;
}

- (void)setStringFormatter:(IDStringFormatter *)stringFormatter
{
    for (IDBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        [productGroup setStringFormatter:stringFormatter];
    }
}

- (void)sort
{
    [self.paymentProductGroups sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IDBasicPaymentProductGroup *productGroup1 = (IDBasicPaymentProductGroup *)obj1;
        IDBasicPaymentProductGroup *productGroup2 = (IDBasicPaymentProductGroup *)obj2;
        
        if (productGroup1.displayHints.displayOrder > productGroup2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (productGroup1.displayHints.displayOrder < productGroup2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
