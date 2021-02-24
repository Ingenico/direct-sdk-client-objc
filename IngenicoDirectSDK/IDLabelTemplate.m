//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDLabelTemplate.h"
#import "IDLabelTemplateItem.h"

@implementation IDLabelTemplate

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.labelTemplateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)maskForAttributeKey:(NSString *)key
{
    for (IDLabelTemplateItem *labelTemplateItem in self.labelTemplateItems) {
        if ([labelTemplateItem.attributeKey isEqualToString:key] == YES) {
            return labelTemplateItem.mask;
        }
    }
    return nil;
}

@end
