//
//  SearchGamesViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 5/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
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
/**
 *  游戏搜索
 */
@interface SearchGamesViewController : BaseViewController<UISearchBarDelegate>{
    ///搜索列表
    SimpleTableViewController * searchTableViewController;
    UISearchBar * searchBar;
    ///关键字
    NSString *searchStr;
}
-(id)initWithTitle:(NSString*)title;

///游戏搜索
@property (nonatomic, strong)UISearchBar * searchBar;

///搜索列表
@property(nonatomic,strong)SimpleTableViewController * searchTableViewController;
///关键字
@property (nonatomic, strong) NSString *searchStr;


/**
 *  清空搜索数据
 */
-(void)clearSearchData;
@end
