//
//  app_ enmu.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#ifndef appgameprivilege_app__enmu_h
#define appgameprivilege_app__enmu_h

/**
 排行榜筛选类型。
 */
typedef enum RankingState {
    /// 热门
    Rankinghot = 1,
    /// 新游戏：
    Rankingnew,
    ///搜索
    Rakingsearch
    
} RankingState;


/**
 tableview 刷新 加载类型。
 */
typedef enum tableviewstyle {
    ///刷新
    tableRefresh = 0,
    /// 加载更多
    tableMore
    
} tableviewstyle;


/**
 游戏详情 tableview 当前显示列表。
 */
typedef enum GameDetailstyle {
    ///描述
    DetailsDescribe=0,
    ///评测
    DetailsReview ,
    /// 活动礼包
    DetailsActivity
    
} GameDetailstyle;

/**
 评测列表 tableview 当前显示列表。
 */
typedef enum ReviewDetailstyle {
    ///攻略
    Reviewstrategy=0,
    ///资讯
    Reviewinformation ,
    /// 视频
    Reviewvideo
    
} ReviewDetailstyle;

/**
 用户状态
 */
typedef enum UserCurtState {
    /**
     *  离线
     */
    OfflineState=0,
    /**
     *  在线
     */
    OnlineState
} UserCurtState;


/**
 活动类型
 */
typedef enum ActivityStateEnum {
    /**
     *  礼包
     */
    Activitygift=1,
    /**
     *活动
     */
    Activityactivity
} ActivityStateEnum;
#endif
