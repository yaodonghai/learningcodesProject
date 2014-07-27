//
//  MyGiftCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 13/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 *  我的礼包 cell
 */
@interface MyGiftCell : BaseCell
/**
 *  截图
 */
@property (weak, nonatomic) IBOutlet UIImageView *giftheadImageView;
/**
 *  活动礼包名称
 */
@property (weak, nonatomic) IBOutlet UILabel *giftNameLable;
/**
 *  兑了换码
 */
@property (weak, nonatomic) IBOutlet UILabel *giftcodeLable;
/**
 *  状态
 */
@property (weak, nonatomic) IBOutlet UILabel *giftstateLable;
@property (weak, nonatomic) IBOutlet UIButton *giftCopyButton;

@end
