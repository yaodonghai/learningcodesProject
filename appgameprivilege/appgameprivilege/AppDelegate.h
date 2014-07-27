//
//  AppDelegate.h
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"
#import "GlobalConfigure.h"
#import "config.h"
#import "iVersion.h"
#import "HomeTabController.h"
#import "OauthViewController.h"
#import "CustomPageControl.h"
//#import "QQViewController.h"
@class emojiViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UIAlertViewDelegate,UIScrollViewDelegate>{
    
    UIView * pageview;
}
- (void) showAlert: (NSString *) message;

- (NSString *)docFilePath;
- (NSString *)dataFilePath;
- (NSString *)tempFilePath;
- (NSString *)imageFilePath;
-(UIButton*)createFooterButton:(NSString*)s action:(SEL)action target:(id)target;

-(NSString*)formatdateFromStr:(NSString*)s format:(NSString*)str;
-(NSString*)formatdate:(NSDate*)d format:(NSString*)str;

@property (retain, nonatomic) emojiViewController* faceView;
@property (strong, nonatomic) UIWindow *window;
/**
 *  oauth 登录
 */
@property (strong, nonatomic) OauthViewController *oauthviewController;


/**
 *  主模块容器
 */
@property(nonatomic,strong)HomeTabController * hometabController;

@property(nonatomic,strong)AppDelegate * delegate;
+(AppDelegate*)shareAppDelegate;
/**
 *  推送注册和注销
 */
- (void) registerNofitication;
@end
