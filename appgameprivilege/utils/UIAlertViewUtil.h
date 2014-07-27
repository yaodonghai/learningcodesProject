//
//  UIAlertViewUtil.h
//  youcoach
//
//  UIAlertView的封装，简化调用代码；有多种形态；
//
//  Created by June on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "global_defines.h"

// 限定两次弹出错误对话框提示的间隔时间
#define LIMIT_TIME_FOR_ERROR_ALERT_INTERVAL 3

#define UIALERTVIEWUTL_TYPE_TAG_CONFIRM 100000

typedef void (^UIAlertViewUtilSubmit) (UIAlertView *alertView);
typedef void (^UIAlertViewUtilCancel) (UIAlertView *alertView);

@interface UIAlertViewUtil : NSObject<UIAlertViewDelegate>
{
    UIAlertViewUtilSubmit confirmSubmitBlock;
    UIAlertViewUtilCancel confirmCancelBlock;
}

- (void)setConfirmSubmitBlock:(UIAlertViewUtilSubmit)block;

- (void)setConfirmCancelBlock:(UIAlertViewUtilCancel)block;

+ (UIAlertViewUtil*)alertView;

+ (UIAlertView*)showAlertWhenValidateFailWithMessage:(NSString*)message;

+ (UIAlertView*)showAlertTipWithMessage:(NSString*)message;

+ (UIAlertView*)showAlertRequestFailWithMessage:(NSString*)message;

+ (UIAlertView*)showAlertErrorTipWithMessage:(NSString*)message;

+ (UIAlertView*)showConfirmTipWithMessage:(NSString*)message;

+ (UIAlertView*)showAlertErrorTipLimitTimeWithMessage:(NSString*)message;

+ (UIAlertView*)showRemindAlertWithMessage:(NSString*)message;

+ (void)showConfirmTipWithMessage:(NSString*)message submit:(UIAlertViewUtilSubmit)submitBlock cancel:(UIAlertViewUtilCancel)cancelBlock;

+ (void)showAlertTipWithMessage:(NSString*)message submit:(UIAlertViewUtilSubmit)submitBlock;

@end
