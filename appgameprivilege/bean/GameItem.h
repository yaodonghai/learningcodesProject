//
//  GameItem.h
//  appgameprivilege
//
//  Created by 姚东海 on 8/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 游戏实体
 */
@interface GameItem : NSObject
///游戏ID
@property(nonatomic,strong)NSString * gameId;

///游戏名称
@property(nonatomic,strong)NSString * gameName;

///游戏icon
@property(nonatomic,strong)NSString * gameIcon;
///游戏 本地icon
@property(nonatomic,strong)NSString * gamedownIconIcon;

///游戏下载量
@property(nonatomic,strong)NSString * gameDowncount;

///游戏下载址
@property(nonatomic,strong)NSString * gameDowurl;
/**
 *  描述
 */
@property(nonatomic,strong)NSString * gamedescribe;


///游戏大小
@property(nonatomic,strong)NSString * gameSize;

///游戏评分
@property(nonatomic,strong)NSString * gameScore;

///游戏上线⽇日期
@property(nonatomic,strong)NSString * gameDate;
///游戏gameURLschemes
@property(nonatomic,strong)NSString *  gameURLschemes;
///游戏版本
@property(nonatomic,strong)NSString * gameVersion;

///游戏收藏(1为已收藏0没有收藏)
@property(nonatomic,assign)int gameIscollection;

///游戏关注(1为已关注0没有关注)
@property(nonatomic,assign)int gameIsfocus;

///游戏赞数量
@property(nonatomic,strong)NSString * praise;
///游戏关注数量
@property(nonatomic,strong)NSString * focuscount;
/**
 *  截图数组
 */
@property(nonatomic,strong)NSMutableArray * screenshots;
/**
 *  新游
 */
@property(nonatomic,assign)BOOL isnew;
/**
 *  热门
 */
@property(nonatomic,assign)BOOL ishot;


/**
 *  当前游戏类型
 */
@property(nonatomic,assign)int curtgametype;

/**
 * @brief 解析游戏实体
 *
 * @param  dic 解析的字典 .
 *
 * @return 返回  GameItem 对象.
 */
-(id)initWithDic:(NSDictionary*)dic;
/**
 *
 *
 *  @param dic 游戏详情内容
 *
 *  @return GameItem
 */
-(id)initWithGameDetailDic:(NSDictionary *)dic;
/**
 *
 *
 *  @param dic 更多应用
 *
 *  @return GameItem
 */
-(id)initWithMoreAppDic:(NSDictionary *)dic;
@end
