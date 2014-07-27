//
//  GameDetailHeadView.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 游戏详情头部view
 */
@interface GameDetailHeadView : UIView
///游戏名称
@property (weak, nonatomic) IBOutlet UILabel *gamenameLable;
///游戏下载量
@property (weak, nonatomic) IBOutlet UILabel *gamedownnumberLalbe;
///游戏赞动作
@property (weak, nonatomic) IBOutlet UIButton *gamezanButton;
///游戏icon
@property (weak, nonatomic) IBOutlet UIImageView *gameiconImageView;
@end
