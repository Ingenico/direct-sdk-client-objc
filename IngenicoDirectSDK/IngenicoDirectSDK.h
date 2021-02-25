//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 17/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

#import <UIKit/UIKit.h>

//! Project version number for IngenicoDirectSDK.
FOUNDATION_EXPORT double IngenicoDirectSDKVersionNumber;

//! Project version string for IngenicoDirectSDK.
FOUNDATION_EXPORT const unsigned char IngenicoDirectSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IngenicoDirectSDK/PublicHeader.h>

#import <IngenicoDirectSDK/IDAssetManager.h>
#import <IngenicoDirectSDK/IDC2SCommunicator.h>
#import <IngenicoDirectSDK/IDC2SCommunicatorConfiguration.h>
#import <IngenicoDirectSDK/IDSession.h>
#import <IngenicoDirectSDK/IDUtil.h>

#import <IngenicoDirectSDK/IDBase64.h>

#import <IngenicoDirectSDK/IDSDKConstants.h>

#import <IngenicoDirectSDK/IDBasicPaymentItemConverter.h>
#import <IngenicoDirectSDK/IDBasicPaymentProductConverter.h>
#import <IngenicoDirectSDK/IDBasicPaymentProductsConverter.h>
#import <IngenicoDirectSDK/IDIINDetailsResponseConverter.h>
#import <IngenicoDirectSDK/IDPaymentContextConverter.h>
#import <IngenicoDirectSDK/IDPaymentItemConverter.h>
#import <IngenicoDirectSDK/IDPaymentProductConverter.h>

#import <IngenicoDirectSDK/IDEncryptor.h>
#import <IngenicoDirectSDK/IDJOSEEncryptor.h>

#import <IngenicoDirectSDK/IDAccountOnFileAttributeStatus.h>
#import <IngenicoDirectSDK/IDEnvironment.h>
#import <IngenicoDirectSDK/IDFormElementType.h>
#import <IngenicoDirectSDK/IDIINStatus.h>
#import <IngenicoDirectSDK/IDPreferredInputType.h>
#import <IngenicoDirectSDK/IDRegion.h>
#import <IngenicoDirectSDK/IDType.h>

#import <IngenicoDirectSDK/IDStringFormatter.h>

#import <IngenicoDirectSDK/IDJSON.h>

#import <IngenicoDirectSDK/IDMacros.h>

#import <IngenicoDirectSDK/IDAccountOnFile.h>
#import <IngenicoDirectSDK/IDAccountOnFileAttribute.h>
#import <IngenicoDirectSDK/IDAccountOnFileAttributes.h>
#import <IngenicoDirectSDK/IDAccountOnFileDisplayHints.h>
#import <IngenicoDirectSDK/IDAccountsOnFile.h>

#import <IngenicoDirectSDK/IDPaymentContext.h>
#import <IngenicoDirectSDK/IDPaymentAmountOfMoney.h>

#import <IngenicoDirectSDK/IDIINDetailsResponse.h>
#import <IngenicoDirectSDK/IDIINDetail.h>

#import <IngenicoDirectSDK/IDBasicPaymentProduct.h>
#import <IngenicoDirectSDK/IDBasicPaymentProducts.h>
#import <IngenicoDirectSDK/IDDataRestrictions.h>
#import <IngenicoDirectSDK/IDDisplayElement.h>
#import <IngenicoDirectSDK/IDDisplayElementsConverter.h>
#import <IngenicoDirectSDK/IDDisplayElementType.h>
#import <IngenicoDirectSDK/IDFormElement.h>
#import <IngenicoDirectSDK/IDLabelTemplate.h>
#import <IngenicoDirectSDK/IDLabelTemplateItem.h>
#import <IngenicoDirectSDK/IDPaymentItemDisplayHints.h>
#import <IngenicoDirectSDK/IDPaymentItems.h>
#import <IngenicoDirectSDK/IDPaymentProduct.h>
#import <IngenicoDirectSDK/IDPaymentProduct302SpecificData.h>
#import <IngenicoDirectSDK/IDPaymentProductField.h>
#import <IngenicoDirectSDK/IDPaymentProductFieldDisplayHints.h>
#import <IngenicoDirectSDK/IDPaymentProductFields.h>
#import <IngenicoDirectSDK/IDPaymentProductNetworks.h>
#import <IngenicoDirectSDK/IDToolTip.h>

#import <IngenicoDirectSDK/IDPaymentRequest.h>
#import <IngenicoDirectSDK/IDPreparedPaymentRequest.h>

#import <IngenicoDirectSDK/IDPublicKeyResponse.h>

#import <IngenicoDirectSDK/IDValidator.h>
#import <IngenicoDirectSDK/IDValidatorEmailAddress.h>
#import <IngenicoDirectSDK/IDValidatorExpirationDate.h>
#import <IngenicoDirectSDK/IDValidatorFixedList.h>
#import <IngenicoDirectSDK/IDValidatorIBAN.h>
#import <IngenicoDirectSDK/IDValidatorLength.h>
#import <IngenicoDirectSDK/IDValidatorLuhn.h>
#import <IngenicoDirectSDK/IDValidatorRange.h>
#import <IngenicoDirectSDK/IDValidatorRegularExpression.h>
#import <IngenicoDirectSDK/IDValidators.h>
#import <IngenicoDirectSDK/IDValidatorTermsAndConditions.h>
#import <IngenicoDirectSDK/IDValueMappingItem.h>

#import <IngenicoDirectSDK/IDValidationError.h>
#import <IngenicoDirectSDK/IDValidationErrorAllowed.h>
#import <IngenicoDirectSDK/IDValidationErrorEmailAddress.h>
#import <IngenicoDirectSDK/IDValidationErrorExpirationDate.h>
#import <IngenicoDirectSDK/IDValidationErrorFixedList.h>
#import <IngenicoDirectSDK/IDValidationErrorIBAN.h>
#import <IngenicoDirectSDK/IDValidationErrorInteger.h>
#import <IngenicoDirectSDK/IDValidationErrorIsRequired.h>
#import <IngenicoDirectSDK/IDValidationErrorLength.h>
#import <IngenicoDirectSDK/IDValidationErrorLuhn.h>
#import <IngenicoDirectSDK/IDValidationErrorNumericString.h>
#import <IngenicoDirectSDK/IDValidationErrorRange.h>
#import <IngenicoDirectSDK/IDValidationErrorRegularExpression.h>
#import <IngenicoDirectSDK/IDValidationErrorTermsAndConditions.h>

#import <IngenicoDirectSDK/IDBasicPaymentItem.h>
#import <IngenicoDirectSDK/IDPaymentItem.h>

#import <IngenicoDirectSDK/IDAFNetworkingWrapper.h>
#import <IngenicoDirectSDK/IDNetworkingWrapper.h>
