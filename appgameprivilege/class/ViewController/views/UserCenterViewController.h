//
//  UserCenterViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "MyGiftViewController.h"
#import "MyfocusViewController.h"
#import "OauthViewController.h"
#import "MoreAppsViewController.h"
#import "UserCenterHeadView.h"
#import "UserCentersCell.h"
/**
 个人中心
 */
@interface UserCenterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    ///个人tableview
    UITableView * userTableview;
    ///标题数据
    NSMutableArray * datatitleArray;
    /**
     *  推送开关
     */
    UISwitch* pushSwitch;
    /**
     *  退出 登录 按扭
     */
    UIButton * exitButton;
}
///个人tableview
@property(nonatomic,strong)UITableView * userTableview;
///标题数据
@property(nonatomic,strong)NSMutableArray * datatitleArray;

/**
 *  退出 登录 按扭
 */
@property(nonatomic,strong)UIButton * exitButton;
/**
 *  选择动作
 *
 *  @param actionid ID
 */
-(void)chooseAction:(int)actionid;
/**
 *  刷新
 */
-(void)refreshTableHeadView;
@end
