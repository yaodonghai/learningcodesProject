//
//  GameDetailsViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "GameDetailHeadView.h"
#import "GameDetaiServerInterface.h"
#import "AlerViewManager.h"
#import "SimpleTableViewController.h"
#import "MJRefresh.h"
#import "GameItem.h"
#import "ActivityItem.h"
#import "ProjectServerInterface.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "SVPullToRefresh.h"
#import "Globle.h"
#import "ActivityServerInterface.h"
#import "ProjectServerInterface.h"
#import "ProjectItem.h"
#import "AKSegmentedControl.h"
#import "GHRootViewController.h"
#import "MCPagerView.h"
#import "ReviewCell.h"
#import "ProjectItem.h"
#import "ActivityCell.h"
#import "HMSideMenu.h"
#import "ScreenCell.h"
#import "GameDescribeScrollView.h"
#import "GameOrderAppView.h"
#import "FocusGameServerInterface.h"
#import "InformationServerInterface.h"
#import "GHRootViewController.h"
#import "ActiviyDetailViewController.h"
/**
 游戏介绍详情
 */
@interface GameDetailsViewController : BaseViewController<UIScrollViewDelegate>{
    ///游戏详情内容 ScrollView
    UIScrollView * gamedetailScrollView;
    ///活动礼包列表
    SimpleTableViewController * activityTableViewController;
    ///活动刷 新view
    //MJRefreshHeaderView * activityTableViewheader;
    ///分组
    AKSegmentedControl *segmentedPerson;
    ///截图
    UIScrollView *   gameimagesScrollView;
    /**
     *  分类view 背景
     */
   // UIView *segBg;
    /**
     *  评测筛选列表
     */
    SimpleTableViewController *reviewsScreenTableViewController;

    ///标记评测列表第一次加载
    BOOL firstreviewload;
    ///标记活动列表第一次加载
    BOOL firstactivityload;
    ///当前显示的列表
    int curtstate;
    /**
     *  当前评测列表
     */
    int curtreviewstate;
    
    /**
     *  模块按扭
     */
    NSMutableArray * classbtns;
    
    /**
     *  评测列表 攻略 资讯 视频
     */
    NSMutableArray * reviewsableViewControllerArray;
    /**
     *  当前是否显示评测 tableview
     */
    BOOL isreviewstate;
    /**
     *  筛选条件 title
     */
    
    NSMutableArray * ScreenTitleArray;
    
    /**
     *  游戏描述
     */
    GameDescribeScrollView * describeScrollView;
    /**
     *  预约
     */
    GameOrderAppView * orderAppView;
    
    /**
     *  当前显示游戏资料的类型
     */
    int gametype;
    
    /**
     *  选择低部线
     */
    UIView * bottemlineView;
    /**
     *  选中低部线
     */
    UIView * curtbottemlineView;
    /**
     *  分组数据
     */
    NSMutableArray *gourData;
    /**
     *  是否第一次加载
     */
    BOOL isAllreviewsFirst;
    /**
     *  下拉图片
     */
    UIImageView * checkttagImageView;

}
///游戏详情内容 ScrollView
@property(nonatomic,strong)UIScrollView * gamedetailScrollView;

/**
 *  预约
 */
@property(nonatomic,strong)GameOrderAppView * orderAppView;

///活动礼包列表
@property(nonatomic,strong)SimpleTableViewController * activityTableViewController;

/**
 *  当前评测列表
 */
@property(nonatomic,assign)int curtreviewstate;


/**
 *  评测筛选列表
 */
@property(nonatomic,strong)SimpleTableViewController *reviewsScreenTableViewController;

/**
 *  评测列表 攻略 资讯 视频
 */
@property(nonatomic,strong)NSMutableArray * reviewsableViewControllerArray;
/**
 *  模块按扭
 */
@property(nonatomic,strong)NSMutableArray * classbtns;

/**
 *  游戏描述
 */
@property(nonatomic,strong)GameDescribeScrollView * describeScrollView;
/**
 *  筛选条件 title
 */
@property(nonatomic,strong)NSMutableArray * ScreenTitleArray;


-(id)initWithTitle:(NSString*)title;
/**
 *  关筛选tableview
 */
-(void)closereviewsScreenTableview;
/**
 *  当前游戏数据包
 */
@property(nonatomic,strong)GameItem * curtGameItem;
/**
 *  当前显示游戏资料的类型
 */
@property(nonatomic,assign)int gametype;

@end
