//
//  ActivityDetailHeadView.h
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  活动礼包head view
 */
@interface ActivityDetailHeadView : UIView
/**
 *  游戏ICON
 */
@property (weak, nonatomic) IBOutlet UIImageView *headiconImageView;
/**
 *  游戏名称
 */
@property (weak, nonatomic) IBOutlet UILabel *title1;
/**
 *  游戏描述
 */
@property (weak, nonatomic) IBOutlet UILabel *title2;
/**
 *  操作 button
 */
@property (weak, nonatomic) IBOutlet UIButton *acticityActionButton;

@end
