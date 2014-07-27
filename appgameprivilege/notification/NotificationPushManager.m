//
//  NotificationPushManager.m
//  appgameprivilege
//
//  Created by 姚东海 on 1/7/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "NotificationPushManager.h"
@implementation NotificationPushManager

#pragma mark - init

static NotificationPushManager  *kSharedNotificationPushManager = nil;
+ (NotificationPushManager*)sharedManager
{
    static dispatch_once_t kSharedManagerOnce;
    dispatch_once(&kSharedManagerOnce, ^{
        kSharedNotificationPushManager = [[NotificationPushManager alloc] init];
    });
    
    return kSharedNotificationPushManager;
    
}

#pragma mark - init data

///**
// 发送订阅频道
// */
//- (void)subscribeChannel
//{
//    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
//    [currentInstallation addUniqueObject:AVOS_PUSH_APP_CHANNEL forKey:@"channels"];
//    [currentInstallation saveInBackground];
//}
//
///**
// 保存installation信息：
// */
//- (void)saveWithDeviceToken:(NSData*)deviceToken
//{
//    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    [currentInstallation saveInBackground];
//}

#pragma mark - for application delegate

/**
 处理程序通过推送通知来启动时的情况
 */
- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *remoteNotificationInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(remoteNotificationInfo)
    {
        [self launchNotificationDelayWithUserInfo:remoteNotificationInfo];
    }
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (userInfo == nil) {
        return;
    }
    
    UIApplicationState appState = [[UIApplication sharedApplication] applicationState];
    
    if(appState == UIApplicationStateActive) {
        [self callLocalNotificationWithUserInfo:userInfo];
        
    } else {
        [self launchNotificationDelayWithUserInfo:userInfo];
    }
}

#pragma mark - local notification

- (void)callLocalNotificationWithUserInfo:(NSDictionary*)userInfo
{
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
  //  NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
   // NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得自定义字段内容
    NSString *urlField = [userInfo valueForKey:@"url"]; //自定义参数，key是自己定义的
   // NSLog(@"content=[%@], badge=[%d], sound=[%@], urlField=[%@]",content,badge,sound,urlField);
    
    // 启用本地通知：
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.userInfo = userInfo;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertBody = content;
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 弹出信息:
    pushInfo = userInfo;
    if ([urlField isKindOfClass:[NSString class]]&&![urlField isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"最新消息"
                                                            message:content
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"忽略", Nil)
                                                  otherButtonTitles:NSLocalizedString(@"查看", Nil), Nil];
        [alertView show];
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"最新消息"
                                                            message:content
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"忽略", Nil)
                                                  otherButtonTitles:nil, Nil];
        [alertView show];
    }
  
}


#pragma mark - launch

- (void)launchNotificationDelayWithUserInfo:(NSDictionary *)userInfo
{
    [self performSelector:@selector(launchNotification:) withObject:userInfo afterDelay:1.0];
}

- (void)launchNotification:(NSDictionary *)userInfo
{
    NSLog(@"launchNotification");//仅在程序关闭时收到推送被调用
    
    // Create a pointer to the Photo object
    NSString *url = [userInfo objectForKey:@"url"];
    [self gotoNotificationDetailPageWithUrl:url];
}

- (void)gotoNotificationDetailPageWithUrl:(NSString*)url
{
    if (url != nil && [url isKindOfClass:[NSString class]]) {
        int curtselectedIndex=  [AppDelegate shareAppDelegate].hometabController.selectedIndex;
        MDSlideNavigationViewController * navigation;
        
        if (curtselectedIndex==0) {
            navigation=[AppDelegate shareAppDelegate].hometabController.navigation1;

        }else if (curtselectedIndex==1){
            navigation=[AppDelegate shareAppDelegate].hometabController.navigation2;

        }else if (curtselectedIndex==2){
            navigation=[AppDelegate shareAppDelegate].hometabController.navigation3;

        }else if (curtselectedIndex==3){
            navigation=[AppDelegate shareAppDelegate].hometabController.navigation4;

        }
            GHRootViewController *vc = [[GHRootViewController alloc] initWithTitle:@"消息页面" withUrl:url];
        [navigation pushViewController:vc animated:YES];
        vc.isshowRefreshView=YES;
        [vc.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

    }
}

#pragma mark - alert view delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [self performSelector:@selector(launchNotification:) withObject:pushInfo afterDelay:1.0];
    }
}

@end
