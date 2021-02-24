// Based on the work of AFNetworking
//
// Copyright (c) 2018 AFNetworking (http://afnetworking.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IDNetworkingWrapper.h"
#import "IDMacros.h"
#import <objc/runtime.h>

NSString * const IDURLResponseSerializationErrorDomain = @"com.ingenico.direct.sdk.error.serialization.response";
NSString * const IDNetworkingTaskDidResumeNotification = @"com.ingenico.direct.sdk.networking.task.resume";
NSString * const IDNetworkingTaskDidCompleteNotification = @"com.ingenico.direct.sdk.networking.task.complete";
NSString * const IDNetworkingTaskDidSuspendNotification = @"com.ingenico.direct.sdk.networking.task.suspend";
NSString * const IDNetworkingTaskDidCompleteErrorKey = @"com.ingenico.direct.sdk.networking.task.complete.error";
NSString * const IDNSURLSessionTaskDidResumeNotification = @"com.ingenico.direct.sdk.networking.nsurlsessiontask.resume";
NSString * const IDNSURLSessionTaskDidSuspendNotification = @"com.ingenico.direct.sdk.networking.nsurlsessiontask.suspend";
NSString * const IDNetworkingTaskDidCompleteSerializedResponseKey = @"com.ingenico.direct.sdk.networking.task.complete.serializedresponse";
NSString * const IDNetworkingOperationFailingURLResponseErrorKey = @"com.ingenico.direct.sdk.serialization.response.error.response";
NSString * const IDNetworkingOperationFailingURLResponseDataErrorKey = @"com.ingenico.direct.sdk.serialization.response.error.data";

static NSError * errorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL IDErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return IDErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    
    return NO;
}

@interface IDNetworkingWrapper ()

@property (strong, nonatomic) NSString *clientSessionId;
@property (strong, nonatomic) NSString *base64EncodedClientMetaInfo;
@property (nonatomic, copy, nullable) NSIndexSet *_acceptableStatusCodes;
@property (nonatomic, copy, nullable) NSSet <NSString *> *_acceptableContentTypes;

@end

@implementation IDNetworkingWrapper

- (instancetype)init {
    
    self._acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    self._acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    
    return self;
}

- (void)getResponseForURL:(NSString *)URL
                  headers:(NSDictionary *)headers
additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure
{
    
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    [self setHeaders:headers forRequest:request];
    
    if (additionalAcceptableStatusCodes != nil) {
        NSMutableIndexSet *acceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndexSet:__acceptableStatusCodes];
        [acceptableStatusCodes addIndexes:additionalAcceptableStatusCodes];
        __acceptableStatusCodes = acceptableStatusCodes;
    }
    
    __block NSURLSessionDataTask *requestTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self handleResponseForMethod:[request HTTPMethod] task:requestTask data:data response:response error:error success:success failure:failure];
        
    }];
    
    requestTask.taskDescription = self.taskDescriptionForSessionTasks;
    [self addNotificationObserverForTask:requestTask];
    
    [requestTask resume];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [[NSNotificationCenter defaultCenter] postNotificationName:IDNetworkingTaskDidResumeNotification object:requestTask];
    });
}

- (void)postResponseForURL:(NSString *)URL
                   headers:(NSDictionary *)headers
            withParameters:(NSDictionary *)parameters
additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure
{
    
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    [self setHeaders:headers forRequest:request];
    
    // Add Content-type header, if not provided
    if (![request valueForHTTPHeaderField:@"Content-Type"]) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    if (additionalAcceptableStatusCodes != nil) {
        NSMutableIndexSet *acceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndexSet:__acceptableStatusCodes];
        [acceptableStatusCodes addIndexes:additionalAcceptableStatusCodes];
        __acceptableStatusCodes = acceptableStatusCodes;
    }
    
    NSError *serializationError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&serializationError];
    [request setHTTPBody:jsonData];
    
    __block NSURLSessionDataTask *requestTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self handleResponseForMethod:[request HTTPMethod] task:requestTask data:data response:response error:error success:success failure:failure];
        
    }];
    
    requestTask.taskDescription = self.taskDescriptionForSessionTasks;
    [self addNotificationObserverForTask:requestTask];
    
    [requestTask resume];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [[NSNotificationCenter defaultCenter] postNotificationName:IDNetworkingTaskDidResumeNotification object:requestTask];
    });
}

- (void)setHeaders:(NSDictionary *)headers
        forRequest:(NSMutableURLRequest *)request
{
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [request setValue:value forHTTPHeaderField:field];
        }
    }];
}

- (void)handleResponseForMethod:(NSString *)httpMethod
                           task:(NSURLSessionDataTask *)requestTask
                           data:(NSData *)data
                       response:(NSURLResponse *)response
                          error:(NSError *)error
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    NSError *apiError;
    BOOL isValid = [self validateResponse:(NSHTTPURLResponse *)response data:data error:&apiError];
    
    if (apiError) {
        userInfo[IDNetworkingTaskDidCompleteErrorKey] = apiError;
    }
    
    NSError *serializationError = nil;
    id responseObject = [self responseObjectForResponse:response data:data error:&serializationError];
    
    if (responseObject) {
        userInfo[IDNetworkingTaskDidCompleteSerializedResponseKey] = responseObject;
    }
    
    if (serializationError) {
        userInfo[IDNetworkingTaskDidCompleteErrorKey] = serializationError;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        // Send notification that the request finished
        [[NSNotificationCenter defaultCenter] postNotificationName:IDNetworkingTaskDidCompleteNotification object:requestTask userInfo:userInfo];
        
        // Call the appropriate callback
        if (!isValid) {
            DLog(@"Error while retrieving response for URL %@: %@", [[requestTask originalRequest] URL], [error localizedDescription]);
            failure(error);
        } else {
            success(responseObject);
        }
    });
}

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    BOOL responseIsValid = YES;
    NSError *validationError = nil;
    
    if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
        if (__acceptableContentTypes && ![__acceptableContentTypes containsObject:[response MIMEType]] &&
            !([response MIMEType] == nil && [data length] == 0)) {
            
            if ([data length] > 0 && [response URL]) {
                NSMutableDictionary *mutableUserInfo = [@{
                    NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: unacceptable content-type: %@", @"AFNetworking", nil), [response MIMEType]],
                    NSURLErrorFailingURLErrorKey:[response URL],
                    IDNetworkingOperationFailingURLResponseErrorKey: response,
                } mutableCopy];
                if (data) {
                    mutableUserInfo[IDNetworkingOperationFailingURLResponseDataErrorKey] = data;
                }
                
                validationError = errorWithUnderlyingError([NSError errorWithDomain:IDURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:mutableUserInfo], validationError);
            }
            
            responseIsValid = NO;
        }
        
        if (__acceptableStatusCodes && ![__acceptableStatusCodes containsIndex:(NSUInteger)response.statusCode] && [response URL]) {
            NSMutableDictionary *mutableUserInfo = [@{
                NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: %@ (%ld)", @"AFNetworking", nil), [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode], (long)response.statusCode],
                NSURLErrorFailingURLErrorKey:[response URL],
                IDNetworkingOperationFailingURLResponseErrorKey: response,
            } mutableCopy];
            
            if (data) {
                mutableUserInfo[IDNetworkingOperationFailingURLResponseDataErrorKey] = data;
            }
            
            validationError = errorWithUnderlyingError([NSError errorWithDomain:IDURLResponseSerializationErrorDomain code:NSURLErrorBadServerResponse userInfo:mutableUserInfo], validationError);
            
            responseIsValid = NO;
        }
    }
    
    if (error && !responseIsValid) {
        *error = validationError;
    }
    
    return responseIsValid;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || IDErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, IDURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    
    NSError *serializationError = nil;
    
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
    
    if (!responseObject)
    {
        if (error) {
            *error = errorWithUnderlyingError(serializationError, *error);
        }
        return nil;
    }
    
    return responseObject;
}

- (NSString *)taskDescriptionForSessionTasks {
    return [NSString stringWithFormat:@"%p", self];
}

- (void)taskDidResume:(NSNotification *)notification {
    NSURLSessionTask *task = notification.object;
    if ([task respondsToSelector:@selector(taskDescription)]) {
        if ([task.taskDescription isEqualToString:self.taskDescriptionForSessionTasks]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:IDNetworkingTaskDidResumeNotification object:task];
            });
        }
    }
}

- (void)taskDidSuspend:(NSNotification *)notification {
    NSURLSessionTask *task = notification.object;
    if ([task respondsToSelector:@selector(taskDescription)]) {
        if ([task.taskDescription isEqualToString:self.taskDescriptionForSessionTasks]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:IDNetworkingTaskDidSuspendNotification object:task];
            });
        }
    }
}

- (void)addNotificationObserverForTask:(NSURLSessionTask *)task {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidResume:) name:IDNSURLSessionTaskDidResumeNotification object:task];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidSuspend:) name:IDNSURLSessionTaskDidSuspendNotification object:task];
}

- (void)removeNotificationObserverForTask:(NSURLSessionTask *)task {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IDNSURLSessionTaskDidSuspendNotification object:task];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IDNSURLSessionTaskDidResumeNotification object:task];
}

@end
