//
//  ToastInputDataView.m
//  appgameprivilege
//
//  Created by 姚东海 on 23/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ToastInputDataView.h"
#import <QuartzCore/QuartzCore.h>
#import "global_defines.h"
#define durationtime 0.3
@implementation ToastInputDataView
@synthesize toastFame;
@synthesize toastBrView;
@synthesize duration;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  添加view
 *
 *  @param fatherView 父容器
 */
-(void)AddToastViewSubFatherView:(UIView*)fatherView{
    if (!toastBrView) {
        toastBrView=[[UIView alloc]initWithFrame:fatherView.frame];
        toastBrView.backgroundColor=RGBA(130, 136, 149, 0.5);
        toastBrView.userInteractionEnabled=YES;
        [toastBrView setHidden:YES];
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureRecognizerAction)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [fatherView addGestureRecognizer:singleRecognizer];
        [fatherView addSubview:toastBrView];
        [fatherView addSubview:self];
        [self initpostion:fatherView];
        self.emailText.delegate=self;
        self.qqText.delegate=self;
    }
}

/**
 *  点击背景
 */
-(void)GestureRecognizerAction{
    self.emailText.text=@"";
    self.qqText.text=@"";
    [self hiddenView];
}




/**
 *  初始化
 */
-(void)initpostion:(UIView*)view{
    CGRect viewFame=self.frame;
    viewFame.origin.x=(view.frame.size.width-self.frame.size.width)*0.5;
    viewFame.origin.y=-self.frame.size.height;
    self.frame=viewFame;
}
/**
 *  显示
 */
-(void)showView{
    [self.toastBrView setHidden:NO];
    float curtduraton=duration>0.0?duration:durationtime;
    [UIView animateWithDuration:curtduraton delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect viewFame=self.frame;
        viewFame.origin.y=20.0;
        self.frame=viewFame;
    } completion:^(BOOL finished) {
        [self.emailText becomeFirstResponder];
    }];
}
/**
 *  隐藏
 */
-(void)hiddenView{
    [self.toastBrView setHidden:YES];
    float curtduraton=duration>0.0?duration:durationtime;
    [UIView animateWithDuration:curtduraton delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect viewFame=self.frame;
        viewFame.origin.y=-self.frame.size.height;
        self.frame=viewFame;
    } completion:^(BOOL finished) {
        [self.emailText resignFirstResponder];
        [self.qqText resignFirstResponder];

    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.emailText) {
        [self.emailText resignFirstResponder];
        [self.qqText becomeFirstResponder];
    }else if (textField==self.qqText){
        [self.qqText resignFirstResponder];
    }
    return YES;
}// called when 'return' key pressed. return NO to ignore.

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
