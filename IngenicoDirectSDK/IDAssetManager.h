//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>

#import "IDBasicPaymentProducts.h"
#import "IDPaymentProduct.h"

@class IDPaymentItems;

@interface IDAssetManager : NSObject

- (void)initializeImagesForPaymentItems:(NSArray *)paymentItems;
- (void)initializeImagesForPaymentItem:(NSObject<IDPaymentItem> *)paymentItem;
- (void)updateImagesForPaymentItemsAsynchronously:(NSArray *)paymentItems baseURL:(NSString *)baseURL;
- (void)updateImagesForPaymentItemAsynchronously:(NSObject<IDPaymentItem> *)paymentItem baseURL:(NSString *)baseURL;
- (void)updateImagesForPaymentItemsAsynchronously:(NSArray *)paymentItems baseURL:(NSString *)baseURL callback:(void(^)(void))callback;
- (void)updateImagesForPaymentItemAsynchronously:(NSObject<IDPaymentItem> *)paymentItem baseURL:(NSString *)baseURL callback:(void(^)(void))callback;
- (UIImage *)logoImageForPaymentItem:(NSString *)paymentItemId;
- (UIImage *)tooltipImageForPaymentItem:(NSString *)paymentItemId field:(NSString *)paymentProductFieldId;

@end
