//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface IDStringFormatter : NSObject

- (NSString *)formatString:(NSString *)string withMask:(NSString *)mask cursorPosition:(NSInteger *)cursorPosition;
- (NSString *)formatString:(NSString *)string withMask:(NSString *)mask;
- (NSString *)unformatString:(NSString *)string withMask:(NSString *)mask;
- (NSString *)relaxMask:(NSString *)mask;

@end
