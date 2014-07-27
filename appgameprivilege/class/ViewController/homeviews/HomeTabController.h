//
//  HomeTabController.h
//  GameStrategys
//
//  Created by 姚东海 on 5/5/14.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFilterView.h"
#import "HMSideMenu.h"
#import "JMTabView.h"
#import "AppConfig.h"
#import "ActivityViewController.h"
#import "RankViewController.h"
#import "ProjectViewController.h"
#import "UserCenterViewController.h"
#import "MDSlideNavigationViewController.h"
#import "SMPageControl.h"
#import "HMSideMenu.h"
#import "XYAlertView.h"
#import "WSCoachMarksView.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//#import <TencentOpenAPI/TencentOAuth.h>

#import "QFObject.h"
//#import <TencentOpenAPI/sdkdef.h>
//#import <TencentOpenAPI/TencentOAuthObject.h>

typedef void (^OauthLoginStateBlock)(int  state,NSString*describe);

/**
 最外层的容器
 */
@interface HomeTabController : UITabBarController<TencentSessionDelegate,JMTabViewDelegate,UIScrollViewDelegate>{

     ///活动
    ActivityViewController * activityViewController;
    ///排行榜
    RankViewController * rankViewController;
    ///主题
    ProjectViewController * projectViewController;
    ///个人
    UserCenterViewController * usercenterViewController;
    
    MDSlideNavigationViewController * navigation1;
    MDSlideNavigationViewController * navigation2;
    MDSlideNavigationViewController * navigation3;
    MDSlideNavigationViewController * navigation4;
    /**
     *  遮罩类
     */
    WSCoachMarksView *  coachMarksView ;
    /**
     *  遮罩类 位置
     */
    NSMutableArray * coachMarks;
    
    /**
     *  低部导航
     */
    JMTabView * tabView;
    
    /**
     *  腾讯OAuth
     */
   TencentOAuth* _tencentOAuth;
    /**
     *  QQ 个人信息
     */
   id _userData;
    
    NSMutableArray* _permissions;
}


@property(nonatomic,strong)MDSlideNavigationViewController * navigation1;
@property(nonatomic,strong)MDSlideNavigationViewController * navigation2;
@property(nonatomic,strong)MDSlideNavigationViewController * navigation3;
@property(nonatomic,strong)MDSlideNavigationViewController * navigation4;
@property (nonatomic, strong) DMFilterView *filterView;

///活动
@property(nonatomic,strong)ActivityViewController * activityViewController;
///排行榜
@property(nonatomic,strong)RankViewController * rankViewController;
///主题
@property(nonatomic,strong)ProjectViewController * projectViewController;
///个人
@property(nonatomic,strong)UserCenterViewController * usercenterViewController;
/**
 *  登录回调
 */
@property (copy, nonatomic) OauthLoginStateBlock loginstateblock;
/**
 *  低部导航
 */
@property(nonatomic,strong)JMTabView * tabView;
/**
 *  遮罩类 位置
 */
@property(nonatomic,strong)NSMutableArray * coachMarks;

/**
 *  遮罩类
 */
@property(nonatomic,strong)WSCoachMarksView *  coachMarksView ;

///清除TabBar所有UI
- (void)hideExistingTabBar;

/**
 *  oauth 登录
 */
-(void)loginOauth;

/**
 *  登录
 */
-(void)loginAction;
/**
 *  登录 返回状态
 */
-(void)loginActionWithLoginStateBlock:(OauthLoginStateBlock)block;
/**
 *  选择登录 返回状态
 */
-(void)isHaveGotoLoginWithLoginStateBlock:(OauthLoginStateBlock)block;
/**
 *  低部选中按扭
 *
 *  @param Index 当前选中
 */
-(void)tableViewdidSelectTabAtIndex:(int)Index;
/**
 *  选择登录
 */
-(void)isHaveGotoLogin;
/**
 *  领取礼包 码
 *
 *  @param activityid 活动ID
 */
- (void)gegiftCode:(NSString*)activityid;
/**
 *  获取QQ 个人信息
 */
-(void)getqqUserinfo;
/**
 * logout
 */
- (void)onClickLogout;

@end
