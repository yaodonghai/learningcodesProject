//
//  config.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#ifndef appgameprivilege_config_h
#define appgameprivilege_config_h
#import "app_ enmu.h"
#define IOS7_SYSTEM   ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)

// ============ 应用配置 ==============
/**
 *  qq 登录成功
 */
static int const QQ_LOGIN_SUCCESSFUL =1;

// 应用名称，用于如首页等显眼位置：

static NSString *const SEVER_API_Test = @"http://192.168.100.168/gc.qq.appgame.com";

// 应用名称，用于如首页等显眼位置：
static NSString *const APP_NAME_FOR_FIRST_PAGE = @"腾讯特权中心";

/// AppStore上的应用ID：
static NSUInteger const APP_STORE_ID = 862971186;

//static NSString *const SEVER_URL = @"http://192.168.200.114/gc.qq.appgame.com";
static NSString *const SEVER_URL = @"http://gc.qq.appgame.com";
static NSString *const APP_SEVER_URL = @"http://db.appgame.com/";

/**
 *  任玩堂主官网
 */
static NSString *const APPGAME_URL = @"http://www.appgame.com";


/**
 *  广告
 */
static NSString *const AD_URL = @"http://gof2.appgame.com/json/qmdgs-home-focus";

// api key
static NSString *const SEVER_API_KEY = @"5FUxy4WV3zuH8W8Y";

// ============ ShareSDK =================
#define CALLBACK_URL                     @"http://www.appgame.com/"
/**
 *  ShareSDK KEY
 */
static NSString *const SHARE_SDK_KEY = @"iosv1101";

/**
 *  微信id
 */
static NSString *const WECHAT_ID = @"wx4868b35061f87885";


/**
 *  新浪微博 key
 */
static NSString *const SINAWEIBO_KEY = @"4149720557";

/**
 *  新浪微博 secret
 */
static NSString *const SINAWEIBO_SECRET = @"000ecdbe204a18925b07824db641c0ff";



/**
 *  腾讯微博 key
 */
static NSString *const TENCEN_WEIBO_KEY = @"1101153139";

/**
 *  腾讯微博 secret
 */
static NSString *const TENCEN_SINAWEIBO_SECRET = @"YujAVeQAoefhhK0r";

/**
 *  腾讯空间 key
 */
static NSString *const TENCEN_SPACE_KEY = @"101003200";

/**
 *  腾讯空间 secret
 */
static NSString *const TENCEN_SPACE_SECRET = @"5596525c9c3d881f5118939d09759b23";

/**
 * 分享内容url
 */
static NSString *const SHARE_CONTENT_URL = @"http://www.appgame.com/";
// ============ 用户信息 =================
/**
 * 登录状态
 */
#define  USER_STATE  @"user_state"

// ============ AVOS =================

// AVOS的应用ID和KEY
static NSString *const AVOS_APP_ID = @"ay7luj3yp1f01k3q14k15xpw3y7g39mxcor22bktwv888xo3";
static NSString *const AVOS_CLIENT_KEY = @"2gk4fmd1t03noj1ltplh00wr3hsvisvjkt1eoi4riyegm28i";

// 当前应用在AVOS push上的订阅频道：
static NSString *const AVOS_PUSH_APP_CHANNEL = @"app";
// ============ 活动配置 ==============
// 活动api地址
static NSString *const SEVER_API_ACTIVITY = @"http://activity.appgame.com/";



// ============ Oauth配置 ==============

/**
 * 在Step1获取的Authorization Code
 */
#define  CODE  @"code"

/**
 *  secret
 */
#define  SECRET  @"￼￼client_secret"

/**
 *  access_token
 */
#define  TOKEN  @"￼￼access_token"

/**
 *  openId
 */
#define  OPENID  @"￼￼openId"

/**
 *  expirationDate
 */
#define  EXPIRATONDATE  @"￼￼expirationdate"

/**
 *  _localAppId
 */
#define  LOCALAPPID  @"￼￼localAppId"

/**
 *  _redirectURI
 */
#define  REDIRECTURL  @"￼￼redirectURI"


/**
 * client_id
 */
#define  CLIENT_ID  @"￼￼client_id"

/**
 * ￼grant_type
 */
#define  GRANT_TYPE  @"￼￼￼grant_type"

/**
 * ￼response_type
 */
#define  RESPONSE_TYPE  @"￼￼￼response_type"

/**
 *  ￼redirect_uri
 */
#define  REDIRECT_URI  @"￼redirect_uri"

/**
 * 客户端想要获取的资源(逗号分隔, 如: username,
 */
#define  SCOPE  @"scope"
/**
 * Oauth 访问url
 */
static NSString *const SEVER_API_Oauth = @"http://passport.appgame.com/oauth";

/**
 * 用户信息URL
 */
static NSString *const SEVER_API_USER = @"http://192.168.100.168";



/**
 * 第一次Oauth 访问接口名
 */
static NSString *const AUTHORIZE_PATH = @"authorize";


/**
 *  Oauth 访问 token接口名
 */
static NSString *const TOKEN_PATH = @"access_token";


/**
 *  客户端在oauth server注册的id client_id
 */
static NSString *const OAUTH_CLIENT_ID = @"iosapp01";
/**
 *  客户端在oauth server注册时获取到的密码￼ secret
 */
static NSString *const OAUTH_CLIENT_SECRET = @"iosapp01";
/**
 *  固定值'authorization_code'
 */
static NSString *const OAUTH_GRANT_TYPE = @"authorization_code";

/**
 *  取用户信息
 */
static NSString *const USER_PATH = @"resource/username";

/**
 *  客户端在oauth server注册的,⽤用来接收Authorization Code的回调地址
 */
static NSString *const OAUTH_REDIRECT_URI = @"http://client.local/callback";



#endif
