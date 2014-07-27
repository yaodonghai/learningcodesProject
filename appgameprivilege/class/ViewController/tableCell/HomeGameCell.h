//
//  HomeGameCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 8/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 首页游戏样式 cell
 */
@interface HomeGameCell : BaseCell{
    
}
///游戏Icon
@property (weak, nonatomic) IBOutlet UIImageView *gameIconImageView;
///游戏名
@property (weak, nonatomic) IBOutlet UILabel *gameNameLable;
///游戏下载
@property (weak, nonatomic) IBOutlet UIButton *gamedownButton;
///游戏下载数量
@property (weak, nonatomic) IBOutlet UILabel *gamedowncountLable;


@end
