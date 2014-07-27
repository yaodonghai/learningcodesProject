//
//  NotificationPushManager.h
//  appgameprivilege
//
//  Created by 姚东海 on 1/7/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHRootViewController.h"
#import "AppDelegate.h"
@interface NotificationPushManager : NSObject{
       NSDictionary *pushInfo;
}
+ (NotificationPushManager*)sharedManager;

//- (void)subscribeChannel;
//- (void)saveWithDeviceToken:(NSData*)deviceToken;
- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)launchNotification:(NSDictionary *)userInfo;
- (void)gotoNotificationDetailPageWithUrl:(NSString*)url;

@end
