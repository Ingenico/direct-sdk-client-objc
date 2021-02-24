//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDBasicPaymentItem.h"
#import "IDAccountOnFile.h"

@class IDStringFormatter;

@interface IDBasicPaymentProductGroup : NSObject <IDBasicPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) IDPaymentItemDisplayHints *displayHints;
@property (nonatomic, strong) IDAccountsOnFile *accountsOnFile;

- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;
- (IDAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;

@end
