//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import  "IDBasicPaymentItemConverter.h"
#import  "IDValidator.h"
#import  "IDBasicPaymentItem.h"
#import  "IDMacros.h"
#import  "IDBasicPaymentProductConverter.h"
#import  "IDAccountOnFileAttribute.h"
#import  "IDLabelTemplateItem.h"

@implementation IDBasicPaymentItemConverter 

- (void)setBasicPaymentItem:(NSObject <IDBasicPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem {
    NSObject *identifier = [rawPaymentItem objectForKey:@"id"];
    if ([identifier isKindOfClass:[NSString class]]) {
        paymentItem.identifier = (NSString *) identifier;
    } else if ([identifier isKindOfClass:[NSNumber class]]) {
        paymentItem.identifier = [(NSNumber *)identifier stringValue];
    }

    [self setPaymentProductDisplayHints:paymentItem.displayHints JSON:[rawPaymentItem objectForKey:@"displayHints"]];
    [self setAccountsOnFile:paymentItem.accountsOnFile JSON:[rawPaymentItem objectForKey:@"accountsOnFile"]];
}

- (void)setPaymentProductDisplayHints:(IDPaymentItemDisplayHints *)displayHints JSON:(NSDictionary *)rawDisplayHints
{
    displayHints.displayOrder = [[rawDisplayHints objectForKey:@"displayOrder"] integerValue];
    displayHints.logoPath = [rawDisplayHints objectForKey:@"logo"];
}

- (void)setAccountsOnFile:(IDAccountsOnFile *)accountsOnFile JSON:(NSArray *)rawAccounts
{
    for (NSDictionary *rawAccount in rawAccounts) {
        IDAccountOnFile *account = [self accountOnFileFromJSON:rawAccount];
        [accountsOnFile.accountsOnFile addObject:account];
    }
}

- (IDAccountOnFile *)accountOnFileFromJSON:(NSDictionary *)rawAccount
{
    IDAccountOnFile *account = [[IDAccountOnFile alloc] init];
    account.identifier = [[rawAccount objectForKey:@"id"] stringValue];
    account.paymentProductIdentifier = [[rawAccount objectForKey:@"paymentProductId"] stringValue];
    [self setAccountOnFileDisplayHints:account.displayHints JSON:[rawAccount objectForKey:@"displayHints"]];
    [self setAttributes:account.attributes JSON:[rawAccount objectForKey:@"attributes"]];
    return account;
}

- (void)setAccountOnFileDisplayHints:(IDAccountOnFileDisplayHints *)displayHints JSON:(NSDictionary *)rawDisplayHints
{
    [self setLabelTemplate:displayHints.labelTemplate JSON:[rawDisplayHints objectForKey:@"labelTemplate"]];
}

- (void)setLabelTemplate:(IDLabelTemplate *)labelTemplate JSON:(NSArray *)rawLabelTemplate
{
    for (NSDictionary *rawLabelTemplateItem in rawLabelTemplate) {
        IDLabelTemplateItem *item = [self labelTemplateItemFromJSON:rawLabelTemplateItem];
        [labelTemplate.labelTemplateItems addObject:item];
    }
}

- (IDLabelTemplateItem *)labelTemplateItemFromJSON:(NSDictionary *)rawLabelTemplateItem
{
    IDLabelTemplateItem *item = [[IDLabelTemplateItem alloc] init];
    item.attributeKey = [rawLabelTemplateItem objectForKey:@"attributeKey"];
    item.mask = [rawLabelTemplateItem objectForKey:@"mask"];
    return item;
}

- (void)setAttributes:(IDAccountOnFileAttributes *)attributes JSON:(NSArray *)rawAttributes
{
    for (NSDictionary *rawAttribute in rawAttributes) {
        IDAccountOnFileAttribute *attribute = [self attributeFromJSON:rawAttribute];
        [attributes.attributes addObject:attribute];
    }
}

- (IDAccountOnFileAttribute *)attributeFromJSON:(NSDictionary *)rawAttribute
{
    IDAccountOnFileAttribute *attribute = [[IDAccountOnFileAttribute alloc] init];
    attribute.key = [rawAttribute objectForKey:@"key"];
    attribute.value = [rawAttribute objectForKey:@"value"];
    NSString *rawStatus = [rawAttribute objectForKey:@"status"];
    if ([rawStatus isEqualToString:@"READ_ONLY"] == YES) {
        attribute.status = IDReadOnly;
    } else if ([rawStatus isEqualToString:@"CAN_WRITE"] == YES) {
        attribute.status = IDCanWrite;
    } else if ([rawStatus isEqualToString:@"MUST_WRITE"] == YES) {
        attribute.status = IDMustWrite;
    } else {
        DLog(@"Status %@ in JSON fragment %@ is invalid", rawStatus, rawAttribute);
    }
    attribute.mustWriteReason = [rawAttribute objectForKey:@"mustWriteReason"];

    return attribute;
}

@end
