//
//  UIAlertViewUtil.m
//  youcoach
//
//  Created by June on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAlertViewUtil.h"

@implementation UIAlertViewUtil

+ (UIAlertViewUtil*)alertView
{
    return [[[self class] alloc] init];
}

+ (UIAlertView*)showAlertWhenValidateFailWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_validation_title_fail") message:message delegate:nil cancelButtonTitle:LC(@"button_title_submit") otherButtonTitles:nil, nil];
    [alert show];
    return alert;

}

+ (UIAlertView*)showAlertTipWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_tip_title") message:message delegate:nil cancelButtonTitle:LC(@"button_title_submit") otherButtonTitles:nil, nil];
    [alert show];
    return alert;
    
}

+ (UIAlertView*)showAlertRequestFailWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_request_fail_title") message:message delegate:nil cancelButtonTitle:LC(@"button_title_submit") otherButtonTitles:nil, nil];
    [alert show];
    return alert;
    
}

+ (UIAlertView*)showAlertErrorTipWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_error_tip_title") message:message delegate:nil cancelButtonTitle:LC(@"button_title_submit") otherButtonTitles:nil, nil];
    [alert show];
    return alert;
    
}

+ (UIAlertView*)showConfirmTipWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_tip_title") message:message delegate:self cancelButtonTitle:LC(@"button_title_cancel") otherButtonTitles:LC(@"button_title_submit"), nil];
    [alert show];
    return alert;
}

// 限定指定时间间隔内不重复弹出错误对话框
static NSTimeInterval kLastTimeForErrorAlert = 0;
+ (UIAlertView*)showAlertErrorTipLimitTimeWithMessage:(NSString*)message
{
    NSTimeInterval currentTimeStamp = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time stamp %f, last: %f, distane: %f", currentTimeStamp, kLastTimeForErrorAlert, currentTimeStamp - kLastTimeForErrorAlert);///
    if (currentTimeStamp - kLastTimeForErrorAlert > LIMIT_TIME_FOR_ERROR_ALERT_INTERVAL) {
        kLastTimeForErrorAlert = currentTimeStamp;
        NSLog(@"show alert!");///
        UIAlertView *alertView = [[self class] showAlertErrorTipWithMessage:message];
        [alertView performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:3.f];
    }
    kLastTimeForErrorAlert = currentTimeStamp;
    return nil;
}

+ (UIAlertView*)showRemindAlertWithMessage:(NSString*)message
{
    return [[self class] showAlertTipWithMessage:message];
}

#pragma mark - blocks

- (void)setConfirmSubmitBlock:(UIAlertViewUtilSubmit)block
{
    confirmSubmitBlock = block;
}

- (void)setConfirmCancelBlock:(UIAlertViewUtilCancel)block
{
    confirmCancelBlock = block;
}

static UIAlertView *kConfirmAlertView = nil;;
static UIAlertViewUtil *kConfirmAlertViewDelegate = nil;;

+ (void)showConfirmTipWithMessage:(NSString*)message submit:(UIAlertViewUtilSubmit)submitBlock cancel:(UIAlertViewUtilCancel)cancelBlock
{
    if (kConfirmAlertViewDelegate == nil) {
        kConfirmAlertViewDelegate = [UIAlertViewUtil alertView];
    }
    
    kConfirmAlertView = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_tip_title") message:message delegate:self cancelButtonTitle:LC(@"button_title_cancel") otherButtonTitles:LC(@"button_title_submit"), nil];
    kConfirmAlertView.delegate = kConfirmAlertViewDelegate;
    
    [kConfirmAlertViewDelegate setConfirmSubmitBlock:submitBlock];
    [kConfirmAlertViewDelegate setConfirmCancelBlock:cancelBlock];
    
    [kConfirmAlertView show];
}

static UIAlertView *kNormalAlertView = nil;;
static UIAlertViewUtil *kNormalAlertViewDelegate = nil;;

+ (void)showAlertTipWithMessage:(NSString*)message submit:(UIAlertViewUtilSubmit)submitBlock
{
    if (kNormalAlertViewDelegate == nil) {
        kNormalAlertViewDelegate = [UIAlertViewUtil alertView];
    }
    
    kNormalAlertView = [[UIAlertView alloc] initWithTitle:LC(@"alert_content_tip_title") message:message delegate:self cancelButtonTitle:LC(@"button_title_submit") otherButtonTitles:nil, nil];
    kNormalAlertView.delegate = kNormalAlertViewDelegate;
    
    [kNormalAlertViewDelegate setConfirmSubmitBlock:submitBlock];
    
    [kNormalAlertView show];
}

#pragma mark - delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 区分多个confirm的情况
    if (alertView == kConfirmAlertView) {
        
        if (buttonIndex == 1) {
            if (confirmSubmitBlock != nil) {
                confirmSubmitBlock(alertView);
            }
            
        } else {
            if (confirmCancelBlock != nil) {
                confirmCancelBlock(alertView);
            }
        }
        
        // clean:
        confirmCancelBlock = nil;
        confirmSubmitBlock = nil;
        kConfirmAlertView = nil;
        kConfirmAlertViewDelegate = nil;
        
    } else if (alertView == kNormalAlertView) {
        
        if (confirmSubmitBlock != nil) {
            confirmSubmitBlock(alertView);
        }
        
        // clean:
        confirmCancelBlock = nil;
        confirmSubmitBlock = nil;
        kNormalAlertView = nil;
        kNormalAlertViewDelegate = nil;
    }
}

@end
