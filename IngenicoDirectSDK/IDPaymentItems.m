//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDPaymentItems.h"
#import "IDBasicPaymentItem.h"
#import "IDStringFormatter.h"
#import "IDPaymentItemDisplayHints.h"
#import "IDAccountsOnFile.h"
#import "IDBasicPaymentProductGroups.h"
#import "IDBasicPaymentProducts.h"
#import "IDPaymentProductGroup.h"

@interface IDPaymentItems ()

@property (strong, nonatomic) IDStringFormatter *stringFormatter;
@property (nonatomic, strong) NSArray *allPaymentItems;

@end

@implementation IDPaymentItems

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentItems = [[NSMutableArray alloc] init];
        self.allPaymentItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype)initWithPaymentProducts:(IDBasicPaymentProducts *)products groups:(IDBasicPaymentProductGroups *)groups {
    self = [self init];
    if (self != nil) {
        self.paymentItems = [NSMutableArray arrayWithArray:[self createPaymentItemsFromProducts:products groups:groups]];
        self.allPaymentItems = products.paymentProducts;
                
    }
    return self;
}

-(NSArray *)createPaymentItemsFromProducts:(IDBasicPaymentProducts *)products groups:(IDBasicPaymentProductGroups *)groups {
    return products.paymentProducts;
}

- (BOOL)hasAccountsOnFile
{
    for (NSObject<IDBasicPaymentItem> *paymentItem in self.paymentItems) {
        if (paymentItem.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (NSObject<IDBasicPaymentItem> *paymentItem in self.paymentItems) {
        [accountsOnFile addObjectsFromArray:paymentItem.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentItem:(NSString *)paymentItemIdentifier
{
    NSObject<IDBasicPaymentItem> *paymentItem = [self paymentItemWithIdentifier:paymentItemIdentifier];
    return paymentItem.displayHints.logoPath;
}

- (NSObject<IDBasicPaymentItem> *)paymentItemWithIdentifier:(NSString *)paymentItemIdentifier
{
    for (NSObject<IDBasicPaymentItem> *paymentItem in self.allPaymentItems) {
        if ([paymentItem.identifier isEqualToString:paymentItemIdentifier] == YES) {
            return paymentItem;
        }
    }
    return nil;
}

- (void)sort
{
    [self.paymentItems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSObject<IDBasicPaymentItem> *paymentItem1 = (NSObject<IDBasicPaymentItem> *)obj1;
        NSObject<IDBasicPaymentItem> *paymentItem2 = (NSObject<IDBasicPaymentItem> *)obj2;
        
        if (paymentItem1.displayHints.displayOrder > paymentItem2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (paymentItem1.displayHints.displayOrder < paymentItem2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
