//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPreferredInputType.h"
#import "IDFormElement.h"
#import "IDToolTip.h"

@interface IDPaymentProductFieldDisplayHints : NSObject

@property (nonatomic) BOOL alwaysShow;
@property (nonatomic) NSInteger displayOrder;
@property (strong, nonatomic) IDFormElement *formElement;
@property (strong, nonatomic) NSString *mask;
@property (nonatomic) BOOL obfuscate;
@property (nonatomic) IDPreferredInputType preferredInputType;
@property (strong, nonatomic) IDTooltip *tooltip;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSURL *link;

@end
