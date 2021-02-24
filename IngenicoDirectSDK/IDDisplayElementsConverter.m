//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import "IDDisplayElementsConverter.h"
#import "IDDisplayElement.h"

@implementation IDDisplayElementsConverter

// TODO type
-(NSArray<IDDisplayElement *> *)displayElementsFromJSON:(NSArray *)json
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in json)
    {
        [arr addObject:[self displayElementFromJSON:dict]];
    }
    return arr;
}

-(IDDisplayElement *)displayElementFromJSON:(NSDictionary *)dict
{
    IDDisplayElement *element = [[IDDisplayElement alloc]init];
    element.identifier = dict[@"id"];
    element.value = dict[@"value"];
    NSString *elementType = dict[@"type"];
    if ([elementType isEqualToString:@"STRING"]) {
        element.type = IDDisplayElementTypeString;
    }
    else if ([elementType isEqualToString:@"CURRENCY"])
    {
        element.type = IDDisplayElementTypeCurrency;

    }
    else if ([elementType isEqualToString:@"PERCENTAGE"])
    {
        element.type = IDDisplayElementTypePercentage;

    }
    else if ([elementType isEqualToString:@"URI"])
    {
        element.type = IDDisplayElementTypeURI;

    }
    else if ([elementType isEqualToString:@"INTEGER"])
    {
        element.type = IDDisplayElementTypeInteger;

    }

    return element;
    
}

@end
