//
//  ProjectViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "ProjectCell.h"
#import "ProjectItem.h"
#import "ArticleItem.h"
#import "AlerViewManager.h"
#import "SimpleTableViewController.h"
#import "MJRefresh.h"
#import "ProjectServerInterface.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "SVPullToRefresh.h"
#import "Globle.h"
#import "GHRootViewController.h"
#import "UIView+CustomLayer.h"
#import "DetailViewController.h"
#import "SVWebViewController.h"
/**
 专题
 */
@interface ProjectViewController : BaseViewController{
    ///主题列表
    SimpleTableViewController * projectTableViewController;

}
///主题列表
@property(nonatomic,strong)SimpleTableViewController * projectTableViewController;


@end
