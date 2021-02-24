//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDDisplayElementType.h"

@interface IDDisplayElement : NSObject

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, assign) IDDisplayElementType type;
@property (nonatomic, retain) NSString *value;

@end
