//
//  ActiviyDetailViewController.h
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseViewController.h"
#import "AlerViewManager.h"
#import "MJRefresh.h"
#import "Globle.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "ToastInputDataView.h"
#import "XibViewLoader.h"
#import "JoinActicityServerInterface.h"
#import "ActivityItem.h"
#import "ActivityDetailHeadView.h"
#import "GiftBagServerInterface.h"
#import "GiftActivityDetaiServerInterface.h"
/**
 *  活动礼包详情
 */
@interface ActiviyDetailViewController : BaseViewController{
   
    /**
     *  头部容器
     */
    ActivityDetailHeadView * headView;

    
    /**
     *  详情内容
     */
    UITextView * content;
    
    /**
     *  内容容器
     */
    UIView * boyView;

    /**
     *  低部按扭
     */
    UIButton * bottemButton;
    
    /**
     *  用户提交输入框
     */
    ToastInputDataView * toastInputView;
    /**
     *  当前活动礼包数据
     */
    ActivityItem * curtactivityItem;
    
    /**
     *  活动类型
     */
    int activityType;
}


/**
 *  头部容器
 */
@property(nonatomic,strong)UIView * headView;



/**
 *  内容容器
 */
@property(nonatomic,strong)UIView * boyView;



/**
 *  详情内容
 */
@property(nonatomic,strong)UITextView * content;

/**
 *  低部按扭
 */
@property(nonatomic,strong)UIButton * bottemButton;

/**
 *  用户提交输入框
 */
@property(nonatomic,strong)ToastInputDataView * toastInputView;
-(id)initWithTitle:(NSString*)title;
/**
 *  当前活动礼包数据
 */
@property(nonatomic,strong)ActivityItem * curtactivityItem;

/**
 *  活动类型
 */
@property(nonatomic,assign)int activityType;
@end
