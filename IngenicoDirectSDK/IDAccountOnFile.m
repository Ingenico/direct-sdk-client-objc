//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDAccountOnFile.h"
#import "IDLabelTemplateItem.h"

@interface IDAccountOnFile ()

@property (strong, nonatomic) IDStringFormatter *stringFormatter;

@end

@implementation IDAccountOnFile

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[IDAccountOnFileDisplayHints alloc] init];
        self.attributes = [[IDAccountOnFileAttributes alloc] init];
    }
    return self;
}

- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId
{
    NSString *mask = [self.displayHints.labelTemplate maskForAttributeKey:paymentProductFieldId];
    return [self maskedValueForField:paymentProductFieldId mask:mask];
}

- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId mask:(NSString *)mask
{
    NSString *value = [self.attributes valueForField:paymentProductFieldId];
    if (mask == nil) {
        return value;
    } else {
        NSString *relaxedMask = [self.stringFormatter relaxMask:mask];
        return [self.stringFormatter formatString:value withMask:relaxedMask];
    }
}

- (BOOL)hasValueForField:(NSString *)paymentProductFieldId
{
    return [self.attributes hasValueForField:paymentProductFieldId];
}

- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId
{
    return [self.attributes fieldIsReadOnly:paymentProductFieldId];
}

- (NSString *)label
{
    NSMutableArray *labelComponents = [[NSMutableArray alloc] init];
    for (IDLabelTemplateItem *labelTemplateItem in self.displayHints.labelTemplate.labelTemplateItems) {
        NSString *value = [self maskedValueForField:labelTemplateItem.attributeKey];
        if (value != nil && [value isEqualToString:@""] == NO) {
            NSString *trimmedValue = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [labelComponents addObject:trimmedValue];
        }
    }
    NSString *label = [labelComponents componentsJoinedByString:@" "];
    return label;
}

@end
