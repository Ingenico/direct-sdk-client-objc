//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDAccountOnFileAttributes.h"
#import "IDAccountOnFileDisplayHints.h"
#import "IDStringFormatter.h"

@interface IDAccountOnFile : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *paymentProductIdentifier;
@property (strong, nonatomic) IDAccountOnFileDisplayHints *displayHints;
@property (strong, nonatomic) IDAccountOnFileAttributes *attributes;

- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId;
- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId mask:(NSString *)mask;
- (BOOL)hasValueForField:(NSString *)paymentProductFieldId;
- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId;
- (NSString *)label;
- (void)setStringFormatter:(IDStringFormatter *)stringFormatter;

@end
