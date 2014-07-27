//
//  OauthServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "OauthServerInterface.h"

@implementation OauthServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_API_Oauth;
        self.apiPath = TOKEN_PATH;
        
//        self.apiUrl = SEVER_API_Test;
//        self.apiPath = @"testmysql.php";
    }
    return self;
}



-(void)getOauth:(NSDictionary*)params {
    
    AFOAuth2Client  * jsonapiClient=[AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:self.apiUrl] clientID:@"1" secret:@"test"];
    NSMutableDictionary *finalParams = [params mutableCopy];
    
    //    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    //    [finalParams setObject:[self createSignStringWithTimpstamp:timestamp] forKey:@"sign"];
    //    [finalParams setObject:[NSString stringWithFormat:@"%.0f", timestamp] forKey:@"time"];
    //    [finalParams setObject:@"ios" forKey:@"clienttype"];
    
    [jsonapiClient postPath:self.apiPath parameters:finalParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __block NSString *jsonString = ((AFURLConnectionOperation*)operation).responseString;
        LOG(@"Oauth---%@",jsonString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
 
}


@end
