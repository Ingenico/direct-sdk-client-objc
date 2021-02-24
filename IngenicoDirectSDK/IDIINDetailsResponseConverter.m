//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDIINDetailsResponseConverter.h"
#import  "IDIINDetail.h"

@implementation IDIINDetailsResponseConverter

- (IDIINDetailsResponse *)IINDetailsResponseFromJSON:(NSDictionary *)rawIINDetailsResponse {
    NSNumber *paymentProductIdNumber = rawIINDetailsResponse[@"paymentProductId"];
    NSString *paymentProductId = [NSString stringWithFormat:@"%@", paymentProductIdNumber];
    NSString *countryCode = rawIINDetailsResponse[@"countryCode"];
    BOOL allowedInContext = NO;
    if (rawIINDetailsResponse[@"isAllowedInContext"] != nil) {
        allowedInContext = [rawIINDetailsResponse[@"isAllowedInContext"] boolValue];
    }
    NSArray *coBrands = [self IINDetailsFromJSON:rawIINDetailsResponse[@"coBrands"]];
    
    if (paymentProductIdNumber == nil) {
        return [[IDIINDetailsResponse  alloc] initWithStatus:IDUnknown];
    }
    else if (allowedInContext == NO) {
        return [[IDIINDetailsResponse  alloc] initWithStatus:IDExistingButNotAllowed];
    }
    else {
        IDIINDetailsResponse *response = [[IDIINDetailsResponse alloc] initWithPaymentProductId:paymentProductId
                                                                                         status:IDSupported
                                                                                       coBrands:coBrands
                                                                                    countryCode:countryCode
                                                                               allowedInContext:allowedInContext];
        return response;
    }
}

- (NSArray *)IINDetailsFromJSON:(NSArray *)IINDetailsArray {
    NSMutableArray *IINDetails = [[NSMutableArray alloc] init];
    for (NSDictionary *rawIINDetail in IINDetailsArray) {
        [IINDetails addObject:[self IINDetailFromJSON:rawIINDetail]];
    }
    return [NSArray arrayWithArray:IINDetails];
}

- (IDIINDetail *)IINDetailFromJSON:(NSDictionary *)rawIINDetail {
    NSString *paymentProductId = [NSString stringWithFormat:@"%@", rawIINDetail[@"paymentProductId"]];
    BOOL allowedInContext = NO;
    if (rawIINDetail[@"isAllowedInContext"] != nil) {
        allowedInContext = [rawIINDetail[@"isAllowedInContext"] boolValue];
    }
    IDIINDetail *detail = [[IDIINDetail alloc] initWithPaymentProductId:paymentProductId allowedInContext:allowedInContext];
    return detail;
}

@end
