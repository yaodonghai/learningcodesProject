//
//  GameDescribeScrollView.h
//  appgameprivilege
//
//  Created by 姚东海 on 26/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailHeadView.h"
#import "GameItem.h"
@interface GameDescribeScrollView : UIScrollView{
    /**
     *  截图
     */
    UIScrollView * gameimagesScrollView;
    /**
     *  头部 游戏信息
     */
    GameDetailHeadView * headview;
}
/**
 *  截图
 */
@property(nonatomic,strong)UIScrollView * gameimagesScrollView;
/**
 *  当前游戏数据包
 */
@property(nonatomic,strong)GameItem * curtGameItem;



/**
 *  头部 游戏信息
 */
@property(nonatomic,strong)GameDetailHeadView * headview;
/**
 *  游戏详情头 view
 */
-(void)creatviewUI;
/**
 *  初始化游戏UI
 *
 *  @param frame fame
 *  @param item  游戏数据
 *
 *  @return GameDescribeScrollView 对象
 */
-(id)initWithFrame:(CGRect)frame AndGameItem:(GameItem*)item;
/**
 *  绑定数据
 */
-(void)bangData;
@end
