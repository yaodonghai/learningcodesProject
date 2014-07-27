//
//  MyfocusCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 5/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseCell.h"
/**
 *  我的关注 cell
 */
@interface MyfocusCell : BaseCell
///游戏Icon
@property (weak, nonatomic) IBOutlet UIImageView *gameIconImageView;
///游戏名
@property (weak, nonatomic) IBOutlet UILabel *gameNameLable;
///游戏下载
@property (weak, nonatomic) IBOutlet UIButton *gamedownButton;
///游戏下载数量
@property (weak, nonatomic) IBOutlet UILabel *gamedowncountLable;
@end
