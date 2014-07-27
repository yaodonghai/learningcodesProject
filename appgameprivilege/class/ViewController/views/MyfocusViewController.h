//
//  MyfocusViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
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
#import "myFocusServerInterface.h"
#import "XYAlertView.h"
/**
 *  我的关注
 */
@interface MyfocusViewController : BaseViewController{
    /**
     *  我的关注游戏列表
     */
    SimpleTableViewController * myFocusTableViewController;

}

/**
 *  我的关注游戏列表
 */
@property(nonatomic,strong)SimpleTableViewController * myFocusTableViewController;

-(id)initWithTitle:(NSString*)title;
@end
