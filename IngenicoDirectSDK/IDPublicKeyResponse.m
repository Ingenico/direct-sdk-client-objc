//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import "IDPublicKeyResponse.h"

@implementation IDPublicKeyResponse

- (instancetype)initWithKeyId:(NSString *)keyId encodedPublicKey:(NSString *)encodedPublicKey
{
    self = [super init];
    if (self != nil) {
        _keyId = keyId;
        _encodedPublicKey = encodedPublicKey;
    }
    return self;
}

@end
