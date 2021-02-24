//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

@class IDAccountsOnFile;
@class IDPaymentItemDisplayHints;

@protocol IDBasicPaymentItem <NSObject>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) IDPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) IDAccountsOnFile *accountsOnFile;

@end
