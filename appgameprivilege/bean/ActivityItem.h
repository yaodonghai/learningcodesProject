//
//  ActivityItem.h
//  appgameprivilege
//
//  Created by 姚东海 on 9/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 活动实体
 */
@interface ActivityItem : NSObject
///活动ID
@property(nonatomic,strong)NSString * activityId;
///游戏ID
@property(nonatomic,strong)NSString * gameId;
///游戏ICON
@property(nonatomic,strong)NSString * gameIcon;
///游戏名称
@property(nonatomic,strong)NSString * gameName;
///游戏下载地址
@property(nonatomic,strong)NSString * gameDownUrl;
///活动名称
@property(nonatomic,strong)NSString * activityName;
///活动缩略图
@property(nonatomic,strong)NSString * activitythumbmail;
///活动类型
@property(nonatomic,strong)NSString * activitycurttype;
///活动开始日期
@property(nonatomic,strong)NSString * activitystarttime;
///活动结日期
@property(nonatomic,strong)NSString * activityendtime;
///活动礼包总数
@property(nonatomic,assign)int activitytotal;
///活动礼包剩数
@property(nonatomic,assign)int  activitysurplus;
///活动内容
@property(nonatomic,strong)NSString * activitycontent;

/**
 *   活动礼包详情
 */
@property(nonatomic,strong)NSString * activitydetail;

/**
 *   cell row
 */
@property(nonatomic,assign)int row;

/**
 *  简介
 */
@property(nonatomic,strong)NSString * activityintro;

/**
 *  规则
 */
@property(nonatomic,strong)NSString * activityrule;

/**
 *  活动内容URL
 */
@property(nonatomic,strong)NSString * activityurl;

///活动状态
@property(nonatomic,assign)int  activityactionstate;
/**
 * 是否参加活动 和领取礼包
 */
@property(nonatomic,assign)int isJoin;

/**
 *  活动显示方式
 */
@property(nonatomic,strong)NSString * activityshowtype;
/**
 *  兑换码
 */
@property(nonatomic,strong)NSString * activitycode;
/**
 * @brief 解析活动实体
 *
 * @param  dic 解析的字典 .
 *
 * @return 返回  ActivityItem 对象.
 */
-(id)initActivityWithDic:(NSDictionary*)dic;
/**
 *  我的礼包解析
 *
 *  @param dic 解析的字典
 *
 *  @return ActivityItem 对象
 */
-(id)initMyGiftWithDic:(NSDictionary*)dic;

/**
 *  活动详情
 *
 *  @param dic DIC
 *
 *  @return activity
 */
-(id)initActivityDetailWithDic:(NSDictionary*)dic;
@end
