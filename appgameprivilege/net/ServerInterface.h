//
//  ServerInterface.h
//  TamingMonster
//
//  Created by June on 14-4-16.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFURLConnectionOperation.h"
#import "config.h"
#import "NSString+encrypto.h"
#import "UIAlertViewUtil.h"
#import "AFOAuth2Client.h"

typedef void (^ServerInterfaceFinished) (AFHTTPRequestOperation *request, NSDictionary *responeData);
typedef void (^ServerInterfaceSuccess) (AFHTTPRequestOperation *request, id resultData, id responeData);
typedef void (^ServerInterfaceFaild) (AFHTTPRequestOperation *request, NSString *code, id responeData);
typedef void (^ServerInterfaceLoading) (BOOL isLoading);
typedef void (^ServerInterfaceError) (AFHTTPRequestOperation *request, NSError *error);
typedef id (^ServerInterfacePauseData) (AFHTTPRequestOperation *request, id responeData);

// http methods:
#define HTTP_METHOD_GET     @"GET"
#define HTTP_METHOD_POST    @"POST"
#define HTTP_METHOD_PUT     @"PUT"
#define HTTP_METHOD_DELETE  @"DELETE"

@interface ServerInterface : NSObject
{
    //block for callback
    ServerInterfaceFinished finishedBlock;
    ServerInterfaceLoading loadingBlock;
    ServerInterfaceError errorBlock;
    ServerInterfaceFaild failBlock;
    ServerInterfaceSuccess successBlock;
    ServerInterfacePauseData pauseDataBlock;
}

@property (nonatomic) NSString  *apiUrl;
@property (nonatomic) NSString  *apiKey;
@property (nonatomic) NSString  *apiPath;
@property (nonatomic) BOOL autoShowErrorMessage;

+ (id)serverInterface;

- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
              loading:(ServerInterfaceLoading)loadingCallback;

- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
                 fail:(ServerInterfaceFaild)failCallback
              loading:(ServerInterfaceLoading)loadingCallback;

- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
                 fail:(ServerInterfaceFaild)failCallback
              loading:(ServerInterfaceLoading)loadingCallback
                error:(ServerInterfaceError)errorCallback;
- (void)postWithParams:(NSDictionary*)params
               success:(ServerInterfaceSuccess)successCallback
                  fail:(ServerInterfaceFaild)failCallback
               loading:(ServerInterfaceLoading)loadingCallback
                 error:(ServerInterfaceError)errorCallback;


@end
