//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#ifndef IngenicoDirectSDKExample_IDIINStatus_h
#define IngenicoDirectSDKExample_IDIINStatus_h

typedef enum {
    IDSupported,
    IDUnsupported,
    IDUnknown,
    IDNotEnoughDigits,
    IDPending,
    IDExistingButNotAllowed
} IDIINStatus;

#endif
