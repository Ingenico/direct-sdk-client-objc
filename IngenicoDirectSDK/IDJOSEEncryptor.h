//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "IDEncryptor.h"

@interface IDJOSEEncryptor : NSObject

- (instancetype)initWithEncryptor:(IDEncryptor *)encryptor;
- (NSString *)encryptToCompactSerialization:(NSString *)JSON withPublicKey:(SecKeyRef)publicKey keyId:(NSString *)keyId;
- (NSString *)decryptFromCompactSerialization:(NSString *)JOSE withPrivateKey:(SecKeyRef)privateKey;

@end
