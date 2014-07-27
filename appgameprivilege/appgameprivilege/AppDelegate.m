//
//  AppDelegate.m
//  appgameprivilege
//
//  Created by 姚东海 on 7/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "AppDelegate.h"
#import "UserData.h"
#import "MDSlideNavigationViewController.h"
//#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import "NotificationPushManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "XGPush.h"
#import "WeiboApi.h"
//#import "YXApi.h"

@implementation AppDelegate
static AppDelegate *app;
@synthesize hometabController;
@synthesize delegate;
@synthesize oauthviewController;
+(AppDelegate*)shareAppDelegate
{
    return app;
}


/**
 *  推送注册和注销
 */
- (void) registerNofitication {
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    BOOL bPush = [standardDefaults boolForKey:kPushDefault];
    if (!bPush) {
     	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }else{
        [XGPush unRegisterDevice];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //[XGPush handleReceiveNotification:nil];

    [XGPush startApp:2200036278 appKey:@"IEEE6S59C22S"];
    //处理程序通过推送通知来启动时的情况
    [[NotificationPushManager sharedManager] didFinishLaunchingWithOptions:launchOptions];
    //推送反馈(app不在前台运行时，点击推送激活时)
    [XGPush handleLaunching:launchOptions];
    [self registerNofitication];

    ///
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect appBound = [[UIScreen mainScreen] applicationFrame];
    [Globle shareInstance].globleWidth = screenRect.size.width; //屏幕宽度
    [Globle shareInstance].globleHeight = appBound.size.height;  //屏幕高度（无顶栏）
    [Globle shareInstance].globleAllHeight = screenRect.size.height;  //屏幕高度（有顶栏）
    [AppConfig shareInstance];
    //参数为ShareSDK官网中添加应用后得到的AppKey
     [ShareSDK registerApp:SHARE_SDK_KEY];
     [self initializePlat];
 
    // 获得用户推送权限：
    [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
  
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];

    //提示评分
    NSInteger numberOfExecutions = [standardDefaults integerForKey:kReviewTrollerRunCountDefault] + 1;
    BOOL reviewDone = [standardDefaults boolForKey:kReviewTrollerDoneDefault];
    [standardDefaults setInteger:numberOfExecutions forKey:kReviewTrollerRunCountDefault];
    [standardDefaults synchronize];
    
    //每运行20次提示评分,如果已经按过yes则不在提示
    if (numberOfExecutions % 50 == 0 && !reviewDone) {
        NSString *title = @"给我们评分";
        NSString *message = @"您的好评将激励我们做的更好.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"不", Nil)
                                                  otherButtonTitles:NSLocalizedString(@"好", Nil), Nil];
        alertView.tag = 101;
        [alertView show];
    }
    
    
    //iVersion 更新检测
   // [iVersion sharedInstance].appStoreID = APP_STORE_ID;
     //初始化
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    app =self;
    hometabController=[[HomeTabController alloc] init];
    self.window.rootViewController = hometabController;
    [self.window makeKeyAndVisible];
    
    [self creartGuideScroller];
    return YES;
}



/**
 *  加载引导图片
 */
-(void)creartGuideScroller{
  

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"lapptag"]boolValue]){
        UIImageView *    loadImageView=[[UIImageView alloc]initWithFrame:self.window.frame];
        
        UIImage * curtimage=nil;
        if (IPhone5) {
            curtimage=[UIImage imageNamed:@"Default-568h-1.png"];
        }else{
            curtimage=[UIImage imageNamed:@"Default-1.png"];
        }
        loadImageView.image=curtimage;
        [self.window addSubview:loadImageView];
      [self performSelector:@selector(disappearAnimation:) withObject:loadImageView afterDelay:1.0];
        
    }else{
        [defaults setBool:YES forKey:@"lapptag"];
     
        CGRect viewFame=CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        pageview=[[UIView alloc]initWithFrame:viewFame];
        pageview.backgroundColor=[UIColor clearColor];
        int imagescount=3;
        viewFame.origin.y=0;
        UIScrollView *  guideScroller=[[UIScrollView alloc]initWithFrame:viewFame];
        guideScroller.backgroundColor=[UIColor clearColor];
        [guideScroller setShowsHorizontalScrollIndicator:NO];
        [guideScroller setShowsVerticalScrollIndicator:NO];
        guideScroller.delegate=self;
        guideScroller.pagingEnabled=YES;
        guideScroller.scrollEnabled=YES;
        CGSize contentsize=guideScroller.contentSize;
        contentsize.width=guideScroller.frame.size.width*(imagescount+1);
        guideScroller.contentSize=contentsize;
        [pageview addSubview:guideScroller];
        [self.window addSubview:pageview];
        
        for (int i=1; i<=imagescount; i++) {
            UIImage * curtimage=nil;
            if (IPhone5) {
                curtimage=[UIImage imageNamed:[NSString stringWithFormat:@"Default-568h-%d.png",i]];

            }else{
                curtimage=[UIImage imageNamed:[NSString stringWithFormat:@"Default-%d.png",i]];

            }
            UIImageView * guideimageview=[[UIImageView alloc]initWithImage:curtimage];
            guideimageview.clipsToBounds=YES;
            guideimageview.userInteractionEnabled=YES;
            guideimageview.frame=CGRectMake((i-1)*guideScroller.frame.size.width, 0.,guideScroller.frame.size.width, guideScroller.frame.size.height);
            [guideScroller addSubview:guideimageview];
            
            if (i==imagescount) {
//                [guideimageview setMenuActionWithBlock:^{
//                    //                [pageview setHidden:YES];
//                    //                [imagepagecontrolview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//                    //                [[NSNotificationCenter defaultCenter] postNotificationName:@"firstload" object:nil];
//                    //
//                    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                        [pageview setAlpha:0.2];
//                    } completion:^(BOOL finished) {
//                        [pageview setHidden:YES];
//                        [imagepagecontrolview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//                        [self performSelector:@selector(disappearAnimation:) withObject:loadImageView afterDelay:2.0];
//
//
//                    }];
//                }];
            }
            
        }
        
        NSArray * images= [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"10-引导页小点-黄色.png"],[UIImage imageNamed:@"10-引导页小点-粉色.png"],[UIImage imageNamed:@"10-引导页小点-蓝色.png"], nil];
        CustomPageControl * pagecontrolview=[[CustomPageControl alloc]initWithFrame:CGRectMake(0, (viewFame.size.height-60), viewFame.size.width,50) AddImageArray:images Withcurtimage:[UIImage imageNamed:@"10-引导页小点-灰色.png"]];
        pagecontrolview.tag=10;
        [pageview addSubview:pagecontrolview];
    }
   
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        CGPoint offset = scrollView.contentOffset;
        int page= offset.x /scrollView.frame.size.width;
       CustomPageControl * imagepagecontrolview=(CustomPageControl*)[pageview viewWithTag:10];
    imagepagecontrolview.selectedpage=page;
       if (page==3) {
           [pageview setHidden:YES];
           [pageview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
           [[NSNotificationCenter defaultCenter] postNotificationName:@"firstload" object:nil];
        
    }

}


/**
 *  消失动画
 */
-(void)disappearAnimation:(UIImageView*)loadImageView{
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [loadImageView setAlpha:0.2];
    } completion:^(BOOL finished) {
        [loadImageView setHidden:YES];
        [loadImageView  removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"firstload" object:nil];
    }];

}



/**
 *  初始化分享功能
 */
- (void)initializePlat
{
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    
    [ShareSDK connectWeChatWithAppId:WECHAT_ID wechatCls:[WXApi class]];
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectSinaWeiboWithAppKey:SINAWEIBO_KEY
//                               appSecret:SINAWEIBO_SECRET
//                             redirectUri:CALLBACK_URL];
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
//    [ShareSDK connectTencentWeiboWithAppKey:TENCEN_WEIBO_KEY
//                                  appSecret:TENCEN_SINAWEIBO_SECRET
//                                redirectUri:CALLBACK_URL
//                                   wbApiCls:[WeiboApi class]];

    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
//    [ShareSDK connectQZoneWithAppKey:TENCEN_SPACE_KEY
//                           appSecret:TENCEN_SPACE_SECRET
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
    
//    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
  
}
//
//
//
//
- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    NSString *string =[url absoluteString];

    if ([string hasPrefix:@"tencent222222"])
    {
        
        id<QQApiInterfaceDelegate> qqApiDelegate = hometabController;
         return [QQApiInterface handleOpenURL:url delegate:qqApiDelegate] || [TencentOAuth HandleOpenURL:url];

    }else{
        return [ShareSDK handleOpenURL:url
                            wxDelegate:self];
    }

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    NSString *string =[url absoluteString];
    
    if ([string hasPrefix:@"tencent222222"])
    {
        id<QQApiInterfaceDelegate> qqApiDelegate = hometabController;
        return [QQApiInterface handleOpenURL:url delegate:qqApiDelegate] || [TencentOAuth HandleOpenURL:url];
        
    }else{
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

							
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送推送时传入的字典信息
    //[XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
      LOG(@"userinfo--%@",notification);
    //删除推送列表中的这一条
    [XGPush delLocationNotification:notification];
    //[XGPush delLocationNotification:@"clockID" userInfoValue:@"myid"];
    
    //清空推送列表
    //[XGPush clearLocalNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
#ifdef DEBUG
    //NSLog(@"development mode");
#else
    //NSLog(@"distribution mode");
#endif
    
  //  //注册设备
   NSString * deviceTokenStr = [XGPush registerDevice: deviceToken];
    
    //打印获取的deviceToken的字符串
   // NSLog(@"deviceTokenStr is %@",deviceTokenStr);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"%@",str);
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    //推送反馈(app在前台运行时)
    [XGPush handleReceiveNotification:userInfo];
    [[NotificationPushManager sharedManager] didReceiveRemoteNotification:userInfo];
    LOG(@"userinfo--%@",userInfo);
    //[XGPush handleReceiveNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark AlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            
            [standardDefaults setBool:YES forKey:kReviewTrollerDoneDefault];
            [standardDefaults synchronize];
            
            NSString *appUrl = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", APP_STORE_ID];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
        }else {
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            
            [standardDefaults setBool:NO forKey:kReviewTrollerDoneDefault];
            [standardDefaults synchronize];
            
        }
    }
}
@end
