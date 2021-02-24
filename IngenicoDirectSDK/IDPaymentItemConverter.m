//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDPaymentItemConverter.h"
#import  "IDPaymentItem.h"
#import  "IDPaymentProductFields.h"
#import  "IDPaymentProductField.h"
#import  "IDMacros.h"
#import  "IDValueMappingItem.h"
#import  "IDValidator.h"
#import  "IDValidatorLuhn.h"
#import  "IDValidatorExpirationDate.h"
#import  "IDValidatorEmailAddress.h"
#import  "IDValidatorRegularExpression.h"
#import  "IDValidatorRange.h"
#import  "IDValidatorLength.h"
#import  "IDValidatorFixedList.h"
#import  "IDDisplayElementsConverter.h"
#import  "IDDisplayElement.h"
#import  "IDValidatorTermsAndConditions.h"
#import  "IDValidatorIBAN.h"

@implementation IDPaymentItemConverter 

- (void)setPaymentItem:(NSObject <IDPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem {
    [self setBasicPaymentItem:paymentItem JSON:rawPaymentItem];
    [self setPaymentProductFields:paymentItem.fields JSON:rawPaymentItem[@"fields"]];
}

//Product Fields converter
- (void)setPaymentProductFields:(IDPaymentProductFields *)fields JSON:(NSArray *)rawFields
{
    for (NSDictionary *rawField in rawFields) {
        IDPaymentProductField *field = [self paymentProductFieldFromJSON:rawField];
        [fields.paymentProductFields addObject:field];
    }
    [fields sort];
}

- (IDPaymentProductField *)paymentProductFieldFromJSON:(NSDictionary *)rawField
{
    IDPaymentProductField *field = [[IDPaymentProductField alloc] init];
    [self setDataRestrictions:field.dataRestrictions JSON:[rawField objectForKey:@"dataRestrictions"]];
    field.identifier = [rawField objectForKey:@"id"];
    field.usedForLookup = ((NSNumber *)[rawField objectForKey:@"usedForLookup"]).boolValue;
    [self setDisplayHints:field.displayHints JSON:[rawField objectForKey:@"displayHints"]];
    [self setType:field rawField:rawField];

    return field;
}

- (void)setType:(IDPaymentProductField *)field rawField:(NSDictionary *)rawField
{
    NSString *rawType = [rawField objectForKey:@"type"];
    if ([rawType isEqualToString:@"string"]) {
        field.type = IDString;
    } else if ([rawType isEqualToString:@"integer"]) {
        field.type = IDInteger;
    } else if ([rawType isEqualToString:@"expirydate"]) {
        field.type = IDExpirationDate;
    } else if ([rawType isEqualToString:@"numericstring"]) {
        field.type = IDNumericString;
    } else if ([rawType isEqualToString:@"boolean"]){
        field.type = IDBooleanString;
    } else if ([rawType isEqualToString:@"date"]){
        field.type = IDDateString;
    } else {
        DLog(@"Type %@ in JSON fragment %@ is invalid", rawType, rawField);
    }
}

- (void)setDisplayHints:(IDPaymentProductFieldDisplayHints *)hints JSON:(NSDictionary *)rawHints
{
    hints.alwaysShow = [[rawHints objectForKey:@"alwaysShow"] boolValue];
    hints.displayOrder = [[rawHints objectForKey:@"displayOrder"] integerValue];
    [self setFormElement:hints.formElement JSON:[rawHints objectForKey:@"formElement"]];
    hints.mask = [rawHints objectForKey:@"mask"];
    hints.obfuscate = [[rawHints objectForKey:@"obfuscate"] boolValue];
    hints.label = [rawHints objectForKey:@"label"];
    hints.link = [NSURL URLWithString:[rawHints objectForKey:@"link"]];
    [self setPreferredInputType:hints JSON:[rawHints objectForKey:@"preferredInputType"]];
    [self setTooltip:hints.tooltip JSON:[rawHints objectForKey:@"tooltip"]];
}

- (void)setPreferredInputType:(IDPaymentProductFieldDisplayHints *)hints JSON:(NSString *)rawPreferredInputType
{
    if ([rawPreferredInputType isEqualToString:@"StringKeyboard"] == YES) {
        hints.preferredInputType = IDStringKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"IntegerKeyboard"] == YES) {
        hints.preferredInputType = IDIntegerKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"EmailAddressKeyboard"]) {
        hints.preferredInputType = IDEmailAddressKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"PhoneNumberKeyboard"]) {
        hints.preferredInputType = IDPhoneNumberKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"DateKeyboard"]) {
        hints.preferredInputType = IDDateKeyboard;
    } else if (rawPreferredInputType == nil) {
        hints.preferredInputType = IDNoKeyboard;
    } else {
        DLog(@"Preferred input type %@ is invalid", rawPreferredInputType);
    }
}

- (void)setTooltip:(IDTooltip *)tooltip JSON:(NSDictionary *)rawTooltip
{
    tooltip.imagePath = [rawTooltip objectForKey:@"image"];
}

- (void)setFormElement:(IDFormElement *)formElement JSON:(NSDictionary *)rawFormElement
{
    [self setFormElementType:formElement JSON:rawFormElement];
}

- (void)setFormElementType:(IDFormElement *)formElement JSON:(NSDictionary *)rawFormElement
{
    NSString *rawType = [rawFormElement objectForKey:@"type"];
    if ([rawType isEqualToString:@"text"] == YES) {
        formElement.type = IDTextType;
    } else if ([rawType isEqualToString:@"currency"] == YES) {
        formElement.type = IDCurrencyType;
    } else if ([rawType isEqualToString:@"list"] == YES) {
        formElement.type = IDListType;
        [self setValueMapping:formElement JSON:[rawFormElement objectForKey:@"valueMapping"]];
    } else if ([rawType isEqualToString:@"date"] == YES) {
        formElement.type = IDDateType;
    } else if ([rawType isEqualToString:@"boolean"] == YES) {
        formElement.type = IDBoolType;
    } else {
        DLog(@"Form element %@ is invalid", rawFormElement);
    }
}

- (void)setValueMapping:(IDFormElement *)formElement JSON:(NSArray *)rawValueMapping
{
    for (NSDictionary *rawValueMappingItem in rawValueMapping) {
        IDValueMappingItem *item = [[IDValueMappingItem alloc] init];
        NSArray *displayElements = [rawValueMappingItem objectForKey:@"displayElements"];
        BOOL foundDisplayElement = NO;
        if (displayElements != nil) {
            IDDisplayElementsConverter *converter = [[IDDisplayElementsConverter alloc]init];
            item.displayElements = [converter displayElementsFromJSON:displayElements];
            for (IDDisplayElement *el in [item displayElements]) {
                if ([el.identifier isEqualToString:@"displayName"]) {
                    item.displayName = el.value;
                    foundDisplayElement = YES;
                }
            }
            if (!foundDisplayElement && item.displayName != nil) {
                IDDisplayElement *el = [[IDDisplayElement alloc]init];
                el.identifier = @"displayName";
                el.value = item.displayName;
                el.type = IDDisplayElementTypeString;
                [item setDisplayElements:[item.displayElements arrayByAddingObject:el]];
            }
        }
        else {
            item.displayName = [rawValueMappingItem objectForKey:@"displayName"];
            IDDisplayElement *el = [[IDDisplayElement alloc]init];
            el.identifier = @"displayName";
            el.value = item.displayName;
            el.type = IDDisplayElementTypeString;
            item.displayElements = [NSArray arrayWithObject:el];
        }
        item.displayName = [rawValueMappingItem objectForKey:@"displayName"];
        item.value = [rawValueMappingItem objectForKey:@"value"];
        [formElement.valueMapping addObject:item];
    }
}

- (void)setDataRestrictions:(IDDataRestrictions *)restrictions JSON:(NSDictionary *)rawRestrictions
{
    restrictions.isRequired = [[rawRestrictions objectForKey:@"isRequired"] boolValue];
    [self setValidators:restrictions.validators JSON:[rawRestrictions objectForKey:@"validators"]];
}

- (void)setValidators:(IDValidators *)validators JSON:(NSDictionary *)rawValidators
{
    IDValidator *validator;
    if ([rawValidators objectForKey:@"luhn"] != nil) {
        validator = [[IDValidatorLuhn alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"expirationDate"] != nil) {
        validator = [[IDValidatorExpirationDate alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"range"] != nil) {
        validator = [self validatorRangeFromJSON:[rawValidators objectForKey:@"range"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"length"] != nil) {
        validator = [self validatorLengthFromJSON:[rawValidators objectForKey:@"length"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"fixedList"] != nil) {
        validator = [self validatorFixedListFromJSON:[rawValidators objectForKey:@"fixedList"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"emailAddress"] != nil) {
        validator = [[IDValidatorEmailAddress alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"regularExpression"] != nil) {
        validator = [self validatorRegularExpressionFromJSON:[rawValidators objectForKey:@"regularExpression"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"termsAndConditions"] != nil) {
        validator = [[IDValidatorTermsAndConditions alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"iban"] != nil) {
        validator = [[IDValidatorIBAN alloc] init];
        [validators.validators addObject:validator];
    }
}

- (IDValidatorRegularExpression *)validatorRegularExpressionFromJSON:(NSDictionary *)rawValidator
{
    NSString *rawRegularExpression = [rawValidator objectForKey:@"regularExpression"];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:rawRegularExpression options:0 error:NULL];
    IDValidatorRegularExpression *validator = [[IDValidatorRegularExpression alloc] initWithRegularExpression:regularExpression];
    return validator;
}

- (IDValidatorRange *)validatorRangeFromJSON:(NSDictionary *)rawValidator
{
    IDValidatorRange *validator = [[IDValidatorRange alloc] init];
    validator.maxValue = [[rawValidator objectForKey:@"maxValue"] integerValue];
    validator.minValue = [[rawValidator objectForKey:@"minValue"] integerValue];
    return validator;
}

- (IDValidatorLength *)validatorLengthFromJSON:(NSDictionary *)rawValidator
{
    IDValidatorLength *validator = [[IDValidatorLength alloc] init];
    validator.maxLength = [[rawValidator objectForKey:@"maxLength"] integerValue];
    validator.minLength = [[rawValidator objectForKey:@"minLength"] integerValue];
    return validator;
}

- (IDValidatorFixedList *)validatorFixedListFromJSON:(NSDictionary *)rawValidator
{
    NSArray *rawValues = [rawValidator objectForKey:@"allowedValues"];
    NSMutableArray *allowedValues = [[NSMutableArray alloc] init];
    for (NSString *value in rawValues) {
        [allowedValues addObject:value];
    }
    IDValidatorFixedList *validator = [[IDValidatorFixedList alloc] initWithAllowedValues:allowedValues];
    return validator;
}

@end
