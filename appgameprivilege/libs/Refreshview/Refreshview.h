//
//  Refreshview.h
//  frameworkDemo
//
//  Created by 姚东海 on 19/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Refreshview;
typedef void (^RefreshwebLoadBlock)(BOOL  state,Refreshview * refreshview);

@interface Refreshview : UIView{
    UIImageView * fefreshimageView;
    NSTimer *myTimer;
    int thepa;
    BOOL isload;
    /**
     *  开始刷新回调
     */
    RefreshwebLoadBlock refreshwebblock;
}
/**
 *  放位置 刷新view
 *
 *  @param Poin 位置
 *
 *  @return 刷新view
 */
-(id)initWithRefreshviewFrame:(CGPoint)Poin;
/**
 *  停止
 */
-(void)stop;
/**
 *  开始
 */
-(void)start;
/**
 *  开始刷新回调
 */
@property (copy, nonatomic) RefreshwebLoadBlock refreshwebblock;

@property(nonatomic,strong)UIImageView * fefreshimageView;
@end
