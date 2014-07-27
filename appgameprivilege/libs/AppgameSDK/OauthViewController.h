//
//  OauthViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "OauthServerInterface.h"
#import "NSDate-Utilities.h"
#import "AppConfig.h"
/**
 *  Oauth 登录
 */
@interface OauthViewController : BaseViewController<UIWebViewDelegate>{
    /**
     *    Oauth请求 UIWebView
     */
    UIWebView * oauthrequestWebView;
    /**
     *  Oauth code
     */
    NSString * code;
    /**
     *  顶部view
     */
    UIImageView * topView;
    
    /**
     *  内容view
     */
    UIView * oauthContentView;
}

/**
 *    Oauth请求 UIWebView
 */
@property(nonatomic,strong)UIWebView * oauthrequestWebView;

/**
 *  顶部view
 */
@property(nonatomic,strong)UIImageView * topView;

/**
 *  内容view
 */
@property(nonatomic,strong)UIView * oauthContentView;
@end
