//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDPaymentContextConverter.h"
#import  "IDPaymentContext.h"
#import  "IDPaymentAmountOfMoney.h"

@implementation IDPaymentContextConverter

- (NSDictionary *)JSONFromPartialCreditCardNumber:(NSString *)partialCreditCardNumber {
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    json[@"bin"] = partialCreditCardNumber;
    return [NSDictionary dictionaryWithDictionary:json];
}

- (NSDictionary *)JSONFromPaymentProductContext:(IDPaymentContext *)paymentProductContext partialCreditCardNumber:(NSString *)partialCreditCardNumber {
    NSDictionary *partialCreditNumberJson = [self JSONFromPartialCreditCardNumber:partialCreditCardNumber];
    NSMutableDictionary *json= [NSMutableDictionary dictionaryWithDictionary:partialCreditNumberJson];
    json[@"paymentContext"] = [self JSONFromPaymentProductContext:paymentProductContext];
    return [NSDictionary dictionaryWithDictionary:json];
}


- (NSDictionary *)JSONFromPaymentProductContext:(IDPaymentContext *)paymentProductContext {
    NSMutableDictionary *rawPaymentProductContext = [[NSMutableDictionary alloc] init];
    NSString *isRecurring = paymentProductContext.isRecurring == YES ? @"true" : @"false";
    rawPaymentProductContext[@"isRecurring"] = isRecurring;
    rawPaymentProductContext[@"countryCode"] = paymentProductContext.countryCode;
    rawPaymentProductContext[@"amountOfMoney"] = [self JSONFromAmountOfMoney:paymentProductContext.amountOfMoney];
    return [NSDictionary dictionaryWithDictionary:rawPaymentProductContext];
}

-(NSDictionary *)JSONFromAmountOfMoney:(IDPaymentAmountOfMoney *)amountOfMoney {
    NSMutableDictionary *rawAmount = [[NSMutableDictionary alloc] init];
    rawAmount[@"amount"] = [NSString stringWithFormat:@"%lu", (unsigned long)amountOfMoney.totalAmount];
    rawAmount[@"currencyCode"] = amountOfMoney.currencyCode;
    return [NSDictionary dictionaryWithDictionary:rawAmount];
}

@end
