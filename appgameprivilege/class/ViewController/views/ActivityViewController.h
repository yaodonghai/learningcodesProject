//
//  ActivityViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityCell.h"
#import "ActivityServerInterface.h"
#import "ActivityItem.h"
#import "AlerViewManager.h"
#import "SimpleTableViewController.h"
#import "MJRefresh.h"
#import "Globle.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "HMSideMenu.h"
#import "SGFocusImageFrame.h"
#import "ArticleItem.h"
#import "SVPullToRefresh.h"
#import "HomeServerInterface.h"
#import "GameItem.h"
#import "HomeGameCell.h"
#import "AdServerInterface.h"
#import "GameListServerInterface.h"
#import "ActiviyDetailViewController.h"
#import "EMHint.h"
/**
 活动
 */
@interface ActivityViewController : BaseViewController<SGFocusImageFrameDelegate,UISearchBarDelegate,EMHintDelegate>{
    
    
    ///活动列表
    SimpleTableViewController * activityTableViewController;

    ///广告数组
    NSMutableArray *  ADarray;

    BOOL first;

    
    /**
     *  登录按扭
     */
  UIButton *loginButton;
    /**
     *  高亮 
     */
    EMHint *_hint;
    id _info;


}

///游戏列表
@property(nonatomic,strong)SimpleTableViewController * activityTableViewController;

///广告数组
@property (nonatomic, strong)NSMutableArray *  ADarray;

/**
 *  登录按扭
 */
@property(nonatomic,strong)UIButton *loginButton;


@property(nonatomic,strong)id _info;

@end
