//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDBasicPaymentProducts.h"

@interface IDBasicPaymentProducts ()

@property (strong, nonatomic) IDStringFormatter *stringFormatter;

@end

@implementation IDBasicPaymentProducts

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProducts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)hasAccountsOnFile
{
    for (IDBasicPaymentProduct *product in self.paymentProducts) {
        if (product.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (IDBasicPaymentProduct *product in self.paymentProducts) {
        [accountsOnFile addObjectsFromArray:product.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentProduct:(NSString *)paymentProductIdentifier
{
    IDBasicPaymentProduct *product = [self paymentProductWithIdentifier:paymentProductIdentifier];
    return product.displayHints.logoPath;
}

- (IDBasicPaymentProduct *)paymentProductWithIdentifier:(NSString *)paymentProductIdentifier
{
    for (IDBasicPaymentProduct *product in self.paymentProducts) {
        if ([product.identifier isEqualToString:paymentProductIdentifier] == YES) {
            return product;
        }
    }
    return nil;
}

- (void)setStringFormatter:(IDStringFormatter *)stringFormatter
{
    for (IDBasicPaymentProduct *basicProduct in self.paymentProducts) {
        [basicProduct setStringFormatter:stringFormatter];
    }
}

- (void)sort
{
    [self.paymentProducts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IDBasicPaymentProduct *product1 = (IDBasicPaymentProduct *)obj1;
        IDBasicPaymentProduct *product2 = (IDBasicPaymentProduct *)obj2;
        
        if (product1.displayHints.displayOrder > product2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (product1.displayHints.displayOrder < product2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
