//
//  UserData.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "config.h"
/**
 个人中心信息
 */
@interface UserData : NSObject

/**
 *  单例
 *
 *  @return UserData
 */
+ (UserData *)shareInstance;


/**
 *  用户名
 */
@property(nonatomic,strong)NSString * username;

/**
 *  用户名ID
 */
@property(nonatomic,strong)NSString * userid;

/**
 *  用户头像
 */
@property(nonatomic,strong)NSString * icon;

/**
 *  性别
 */
@property(nonatomic,strong)NSString * gender;

/**
 *  用户头邮箱
 */
@property(nonatomic,strong)NSString * mail;
/**
 *  初始化
 */
-(void)initdata;
/**
 *  保存QQ个人信息
 */
-(void)saveUserinfo;

/**
 *  清用户信息
 */
-(void)clearuserinfo;

@end
