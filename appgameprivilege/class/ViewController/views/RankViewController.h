//
//  RankViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "AlerViewManager.h"
#import "SimpleTableViewController.h"
#import "MJRefresh.h"
#import "HomeGameCell.h"
#import "GameItem.h"
#import "HomeServerInterface.h"
#import "Globle.h"
#import "RankingCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "HMSideMenu.h"
#import "SVPullToRefresh.h"
#import "AKSegmentedControl.h"
#import "GameDetailsViewController.h"
#import "ForwardGameCell.h"
#import "GameListServerInterface.h"
/**
 排行榜
 */
@interface RankViewController : BaseViewController<UIScrollViewDelegate>{
    ///热门游戏列表
    SimpleTableViewController * hotTableViewController;

    ///新游戏列表
    SimpleTableViewController * newsTableViewController;

    ///筛选类型
    int rankstate;
    ///筛选按扭组
    AKSegmentedControl *  segmentedPerson;
    /**
     *  容器
     */
    UIScrollView * contentScrollView;
    
    ///新游戏是否第一次加载
    BOOL isnewgametag;
    
    /**
     *  当前只有一个新游戏的时候游戏数据包
     */
   GameItem * curtGameItem;
    
    /**
     *  游戏描述
     */
    GameDescribeScrollView * describeScrollView;
    /**
     *  热门加载中
     */
    BOOL hotloading;
    /**
     *  新游戏加载中
     */
    BOOL newloading;
    
    /**
     *  选择低部线
     */
    UIView * bottemlineView;
    /**
     *  选中低部线
     */
    UIView * curtbottemlineView;
    
}
///热门游戏列表
@property(nonatomic,strong)SimpleTableViewController * hotTableViewController;

   ///新游戏列表
@property(nonatomic,strong)SimpleTableViewController * newsTableViewController;

///筛选按扭组
@property(nonatomic,strong)AKSegmentedControl *  segmentedPerson;

///筛选类型
@property(nonatomic,assign)int rankstate;
/**
 *  容器
 */
@property(nonatomic,strong)UIScrollView * contentScrollView;
/**
 *  游戏描述
 */
@property(nonatomic,strong)GameDescribeScrollView * describeScrollView;
/**
 *  当前只有一个新游戏的时候游戏数据包
 */
@property(nonatomic,strong)GameItem * curtGameItem;


/**
 *  热门加载中
 */
@property(nonatomic,assign)BOOL hotloading;

/**
 *  新游戏加载中
 */
@property(nonatomic,assign)BOOL newloading;
@end
