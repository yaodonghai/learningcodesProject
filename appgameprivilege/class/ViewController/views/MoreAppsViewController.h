//
//  MoreAppsViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 14/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreAppsServerInterface.h"
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
#import "MoreAppCell.h"
#import "MoreAppsServerInterface.h"

/**
 *  更多应用
 */
@interface MoreAppsViewController : BaseViewController{

    /**
     *  更多应用
     */
    SimpleTableViewController * moreAppTableviewController;

}
/**
 *  更多应用
 */
@property(nonatomic,strong)SimpleTableViewController * moreAppTableviewController;

-(id)initWithTitle:(NSString*)title;
@end
