//
//  AppConfig.h
//  ChainWar
//
//  Created by June on 14-4-9.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "GameItem.h"
/**
 APP 设置信息
 */
@interface AppConfig : NSObject

//===================授权信息=================
/**
 *  token
 */
@property(nonatomic,strong)NSString * access_token;

/**
 *  access_UserId  预留
 */
@property(nonatomic,strong)NSString * access_UserId;

/**
 *  accessTokenType
 */
@property(nonatomic,assign)int  accessTokenType;

/**
 *  accessTokenExpiration
 */
@property(nonatomic,assign)long long   accessTokenExpiration;

/**
 *  openId
 */
@property(nonatomic,strong)NSString * openId;


/**
 *  localAppId
 */
@property(nonatomic,strong)NSString * localAppId;

/**
 *  expirationDate
 */
@property(nonatomic,assign)double expirationDate;

/**
 *  redirectURI
 */
@property(nonatomic,strong)NSString * redirectURI;

/**
 *  pfKey
 */
@property(nonatomic,strong)NSString * pfKey;

/**
 *  pf
 */
@property(nonatomic,strong)NSString *  pf;

/**
 *  platform
 */
@property(nonatomic,assign)int   platform;

/**
 *  refreshTokenExpiration
 */
@property(nonatomic,assign)int  refreshTokenExpiration;

/**
 *  refreshTokenType
 */
@property(nonatomic,assign)int refreshTokenType;

/**
 *  refreshTokenValue
 */
@property(nonatomic,strong)NSString* refreshTokenValue;


/**
 *  updateTime
 */
@property(nonatomic,assign)int updateTime;

/**
 *  flag
 */
@property(nonatomic,assign)int flag;

/**
 *  登录 返回的描述
 */
@property(nonatomic,strong)NSString * describe;

//===============用户信息================


/**
 *  用户信息
 */
@property(nonatomic,strong)UserData * user;

/**
 *  用户是否在线或者是否登录
 */
@property(nonatomic,assign)BOOL isLogin;


/**
 *  单例
 *
 *  @return AppConfig
 */
+ (AppConfig *)shareInstance;

/**
 *  注销用户信息
 */
-(void)cancellation;

/**
 *  初始化
 */
-(void)initAppdata;
//==============测试数据===========
/**
 *  游戏描述测试数据
 *
 *  @return GameItem
 */
+(GameItem*)getdescribeGameData;
+ (NSString*)appId;

+ (NSString*)deviceId;

/**
 *  检测  登录
 *
 *  @return YES NO
 */
-(BOOL)isCheckLongin;

-(void)logoutattribute;

/**
 *  保存oauthinfo
 */
-(void)saveOauthInfo;
/**
 *  token 是否过期
 *
 *  @return YES or NO
 */
-(BOOL)isTokenOverdue;


@end
