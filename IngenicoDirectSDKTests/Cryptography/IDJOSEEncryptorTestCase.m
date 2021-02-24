//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <XCTest/XCTest.h>
#import "IDEncryptor.h"
#import "IDJOSEEncryptor.h"

@interface IDJOSEEncryptorTestCase : XCTestCase

@property (strong, nonatomic) IDEncryptor *encryptor;
@property (strong, nonatomic) IDJOSEEncryptor *JOSEEncryptor;
@property (nonatomic) SecKeyRef publicKey;
@property (nonatomic) SecKeyRef privateKey;

@end

@implementation IDJOSEEncryptorTestCase

- (void)setUp
{
    [super setUp];
    self.encryptor = [[IDEncryptor alloc] init];
    self.JOSEEncryptor = [[IDJOSEEncryptor alloc] initWithEncryptor:self.encryptor];
    [self.encryptor generateRSAKeyPairWithPublicTag:@"test-public-key" privateTag:@"test-private-key"];
    self.publicKey = [self.encryptor RSAKeyWithTag:@"test-public-key"];
    self.privateKey = [self.encryptor RSAKeyWithTag:@"test-private-key"];
}

- (void)tearDown
{
    [super tearDown];
    [self.encryptor deleteRSAKeyWithTag:@"test-public-key"];
    [self.encryptor deleteRSAKeyWithTag:@"test-private-key"];
}

//- (void)testRevertible
//{
//    NSString *input = @"Will this encrypt and decrypt properly?";
//    NSString *keyId = @"doesn't matter now";
//    NSString *encrypted = [self.JOSEEncryptor encryptToCompactSerialization:input withPublicKey:self.publicKey keyId:keyId];
//    NSString *decrypted = [self.JOSEEncryptor decryptFromCompactSerialization:encrypted withPrivateKey:self.privateKey];
//    NSArray *parts = [decrypted componentsSeparatedByString:@"\n"];
//    NSString *output = parts[1];
//    XCTAssertTrue([input isEqualToString:output], @"String is not equal to original version after encrypting and decrypting according to the JOSE standard");
//}

@end
