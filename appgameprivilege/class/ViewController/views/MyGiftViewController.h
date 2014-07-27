//
//  MyGiftViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
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
#import "MyGiftCell.h"
#import "MyGiftPagsServerInterface.h"
/**
 *  我的礼包
 */
@interface MyGiftViewController : BaseViewController{
    /**
     *  我的礼包列表
     */
    SimpleTableViewController * myGiftTableViewController;
    

}

/**
 *  我的礼包列表
 */
@property(nonatomic,strong)SimpleTableViewController * myGiftTableViewController;


-(id)initWithTitle:(NSString*)title;
@end
