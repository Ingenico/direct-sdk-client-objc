//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDPaymentProduct.h"
#import "IDPaymentRequest.h"

@interface IDPaymentRequest : NSObject

@property (strong, nonatomic) IDPaymentProduct *paymentProduct;
@property (strong, nonatomic) IDAccountOnFile *accountOnFile;
@property (strong, nonatomic) NSMutableArray *errors;
@property (nonatomic) BOOL tokenize;

- (void)setValue:(NSString *)value forField:(NSString *)paymentProductFieldId;
- (void)validate;
- (BOOL)fieldIsPartOfAccountOnFile:(NSString *)paymentProductFieldId;
- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId;
- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId;
- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId cursorPosition:(NSInteger *)cursorPosition;
- (NSString *)unmaskedValueForField:(NSString *)paymentProductFieldId;
- (NSDictionary *)unmaskedFieldValues;

@end
