//
//  ServerInterface.m
//  TamingMonster
//
//  Created by June on 14-4-16.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import "ServerInterface.h"
#import "AppConfig.h"
@implementation ServerInterface

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl  = SEVER_URL;
        self.apiKey  = SEVER_API_KEY;
        self.apiPath = @"";
        self.autoShowErrorMessage = YES;
    }
    return self;
}

+ (id)serverInterface
{
    return [[[self class] alloc] init];
}

#pragma mark - block methods

- (void)setFinishedBlock:(ServerInterfaceFinished)block
{
    finishedBlock = block;
}

- (void)setLoadingBlock:(ServerInterfaceLoading)block
{
    loadingBlock = block;
}

- (void)setErrorBlock:(ServerInterfaceError)block
{
    errorBlock = block;
}

- (void)setFailBlock:(ServerInterfaceFaild)block
{
    failBlock = block;
}

- (void)setSuccessBlock:(ServerInterfaceSuccess)block
{
    successBlock = block;
}

- (void)setPauseDataBlock:(ServerInterfacePauseData)block
{
    pauseDataBlock = block;
}


- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
                 fail:(ServerInterfaceFaild)failCallback
              loading:(ServerInterfaceLoading)loadingCallback
{
    [self getWithParams:params success:successCallback fail:failCallback loading:loadingCallback error:nil];
}

- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
              loading:(ServerInterfaceLoading)loadingCallback
{
    [self getWithParams:params success:successCallback fail:nil loading:loadingCallback error:nil];
}



/**
 *  get 请求网络数据
 *
 *  @param params          请求参数
 *  @param successCallback 成功
 *  @param failCallback   失败
 *  @param loadingCallback 加载
 *  @param errorCallback   网络错误
 */
- (void)getWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
                 fail:(ServerInterfaceFaild)failCallback
              loading:(ServerInterfaceLoading)loadingCallback
                error:(ServerInterfaceError)errorCallback
{
    AFHTTPClient *jsonapiClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:self.apiUrl]];
 
    if (![params isKindOfClass:[NSDictionary class]]||params==nil) {
        params=[[NSDictionary alloc]init];
    }
    NSMutableDictionary *finalParams = [params mutableCopy];
    
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    
    [finalParams setObject:[self createSignStringWithTimpstamp:timestamp] forKey:@"sign"];
    [finalParams setObject:[NSString stringWithFormat:@"%.0f", timestamp] forKey:@"time"];
    [finalParams setObject:@"2" forKey:@"clienttype"];
    [finalParams setObject:[AppConfig deviceId] forKey:@"deviceid"];
    
    if ([AppConfig shareInstance].isLogin==OnlineState&&[[AppConfig shareInstance].openId isKindOfClass:[NSString class]]) {
        [finalParams setObject:[AppConfig shareInstance].openId forKey:@"userid"];

    }
    
    if (loadingCallback) {
        loadingCallback(YES);
    }
    
    [jsonapiClient getPath:self.apiPath
                parameters:finalParams
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       __block NSString *jsonString = ((AFURLConnectionOperation*)operation).responseString;
                      LOG(@"get-respon---%@",jsonString);
                       //过滤掉w3tc缓存附加在json数据后面的
                       /*
                        <!-- W3 Total Cache: Page cache debug info:
                        
                        Engine:             memcached
                        Cache key:          4e14f98a5d7a178df9c7d3251ace098d
                        Caching:            enabled
                        Status:             not cached
                        Creation Time:      2.143s
                        Header info:
                        X-Powered-By:        PHP/5.4.14-1~precise+1
                        X-W3TC-Minify:       On
                        Last-Modified:       Sun, 12 May 2013 16:17:48 GMT
                        Vary:
                        X-Pingback:           http://www.appgame.com/xmlrpc.php
                        Content-Type:         application/json; charset=UTF-8
                        -->
                        */
                       NSError *error;
                       //(.|\\s)*或([\\s\\S]*)可以匹配包括换行在内的任意字符
                       NSRegularExpression *regexW3tc = [NSRegularExpression
                                                         regularExpressionWithPattern:@"<!-- W3 Total Cache:([\\s\\S]*)-->"
                                                         options:NSRegularExpressionCaseInsensitive
                                                         error:&error];
                       [regexW3tc enumerateMatchesInString:jsonString
                                                   options:0
                                                     range:NSMakeRange(0, jsonString.length)
                                                usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                                    jsonString = [jsonString stringByReplacingOccurrencesOfString:[jsonString substringWithRange:result.range] withString:@""];
                                                }];
                       
                       jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                       NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                       NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                       NSNumber *code = [responseDictionary objectForKey:@"status"];
                       
                       if ( ([code isKindOfClass:[NSNumber class]] && [code intValue] == 1)
                           || ([code isKindOfClass:[NSString class]] && [(NSString*)code isEqualToString:@"ok"])) {
                           if (successCallback) {
                               //result posts
                               NSDictionary *resultData = [responseDictionary objectForKey:@"result"];
                               NSDictionary *resultData1 = [responseDictionary objectForKey:@"posts"];
                               
                               if (([resultData isKindOfClass:[NSNull class]]||resultData==nil)&&([resultData1 isKindOfClass:[NSNull class]]||resultData1==nil)) {
                                   successCallback(operation, nil, responseDictionary);

                               }else if ((![resultData isKindOfClass:[NSNull class]]&&resultData!=nil)&&([resultData1 isKindOfClass:[NSNull class]]||resultData1==nil)){
                                   successCallback(operation, resultData, responseDictionary);

                               }else if ((![resultData1 isKindOfClass:[NSNull class]]&&resultData1!=nil)&&([resultData isKindOfClass:[NSNull class]]||resultData==nil)){
                                   successCallback(operation, resultData1, responseDictionary);
                                   
                               }else{
                                   successCallback(operation, nil, responseDictionary);

                               }
                           }
                           
                       }else {
                           if (failCallback) {
                               NSString * error_message=[responseDictionary objectForKey:@"msg"];
                               
                               if ([error_message isKindOfClass:[NSString class]]) {
                                   failCallback(operation, error_message, responseDictionary);

                               }else{
                                   failCallback(operation, [NSString stringWithFormat:@"%@",  code], responseDictionary);
                               }
                           }
                           
                       }
                       
                       if (loadingCallback) {
                           loadingCallback(NO);
                       }
                   }
     
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       if ([error isKindOfClass:[NSError class]]) {
                           if (errorCallback) {
                               errorCallback(operation, error);
                           }
                           
                       } else if(self.autoShowErrorMessage) {
                           
                           [UIAlertViewUtil showAlertErrorTipLimitTimeWithMessage:@"请求发生错误，请重试！"];
                           
                       }
                       if (loadingCallback) {
                           loadingCallback(NO);
                       }
                   }];

}


/**
 *  post 请求网络数据
 *
 *  @param params          请求参数
 *  @param successCallback 成功
 *  @param failCallback   失败
 *  @param loadingCallback 加载
 *  @param errorCallback   网络错误
 */
- (void)postWithParams:(NSDictionary*)params
              success:(ServerInterfaceSuccess)successCallback
                 fail:(ServerInterfaceFaild)failCallback
              loading:(ServerInterfaceLoading)loadingCallback
                error:(ServerInterfaceError)errorCallback
{
    AFHTTPClient *jsonapiClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:self.apiUrl]];
    if (![params isKindOfClass:[NSDictionary class]]||params==nil) {
        params=[[NSDictionary alloc]init];
    }
    NSMutableDictionary *finalParams = [params mutableCopy];

    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    [finalParams setObject:[self createSignStringWithTimpstamp:timestamp] forKey:@"sign"];
    [finalParams setObject:[NSString stringWithFormat:@"%.0f", timestamp] forKey:@"time"];
    [finalParams setObject:@"2" forKey:@"clienttype"];
    [finalParams setObject:[AppConfig deviceId] forKey:@"deviceid"];

    if ([AppConfig shareInstance].isLogin==OnlineState&&[[AppConfig shareInstance].openId isKindOfClass:[NSString class]]) {
        [finalParams setObject:[AppConfig shareInstance].openId forKey:@"userid"];
        
    }
    if (loadingCallback) {
        loadingCallback(YES);
    }
    
    [jsonapiClient postPath:self.apiPath
                parameters:finalParams
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       __block NSString *jsonString = ((AFURLConnectionOperation*)operation).responseString;
                       LOG(@"post-respon---%@",jsonString);
                       jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                       NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                       NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                       NSNumber *code = [responseDictionary objectForKey:@"status"];
                       
                       if ( ([code isKindOfClass:[NSNumber class]] && [code intValue] == 1)
                           || ([code isKindOfClass:[NSString class]] && [(NSString*)code isEqualToString:@"ok"])) {
                           if (successCallback) {
                               //result posts
                               NSDictionary *resultData = [responseDictionary objectForKey:@"result"];
                               NSDictionary *resultData1 = [responseDictionary objectForKey:@"posts"];
                               
                               if (([resultData isKindOfClass:[NSNull class]]||resultData==nil)&&([resultData1 isKindOfClass:[NSNull class]]||resultData1==nil)) {
                                   successCallback(operation, nil, responseDictionary);
                                   
                               }else if ((![resultData isKindOfClass:[NSNull class]]&&resultData!=nil)&&([resultData1 isKindOfClass:[NSNull class]]||resultData1==nil)){
                                   successCallback(operation, resultData, responseDictionary);
                                   
                               }else if ((![resultData1 isKindOfClass:[NSNull class]]&&resultData1!=nil)&&([resultData isKindOfClass:[NSNull class]]||resultData==nil)){
                                   successCallback(operation, resultData1, responseDictionary);
                                   
                               }else{
                                   successCallback(operation, nil, responseDictionary);
                                   
                               }
                           }
                           
                       }else {
                           if (failCallback) {
                               NSString * error_message=[responseDictionary objectForKey:@"msg"];
                               
                               if ([error_message isKindOfClass:[NSString class]]) {
                                   failCallback(operation, error_message, responseDictionary);
                                   
                               }else{
                                   failCallback(operation, [NSString stringWithFormat:@"%@",  code], responseDictionary);
                               }
                           }
                           
                       }
                       
                       if (loadingCallback) {
                           loadingCallback(NO);
                       }                   }
     
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if ([error isKindOfClass:[NSError class]]) {
                           errorCallback(operation, error);
                           
                       } else if(self.autoShowErrorMessage) {
                           [UIAlertViewUtil showAlertErrorTipLimitTimeWithMessage:@"请求发生错误，请重试！"];
                           
                       }
                       if (loadingCallback) {
                           loadingCallback(NO);
                       }
                   }];
    
}



- (NSString*)createSignStringWithTimpstamp:(NSTimeInterval)timestamp
{
    NSString *string = [NSString stringWithFormat:@"%@%.0f", self.apiKey, timestamp];
    
    NSString *sign = [string md5];
    return sign;
}

@end
