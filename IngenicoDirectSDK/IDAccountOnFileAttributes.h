//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDAccountOnFileAttributes : NSObject

@property (strong, nonatomic) NSMutableArray *attributes;

- (NSString *)valueForField:(NSString *)paymentProductFieldId;
- (BOOL)hasValueForField:(NSString *)paymentProductFieldId;
- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId;

@end
