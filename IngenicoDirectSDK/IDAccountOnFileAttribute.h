//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDAccountOnFileAttributeStatus.h"

@interface IDAccountOnFileAttribute : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *formattedValue;
@property (nonatomic) IDAccountOnFileAttributeStatus status;
@property (nonatomic) NSString *mustWriteReason;

@end
