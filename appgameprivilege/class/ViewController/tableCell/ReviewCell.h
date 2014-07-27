//
//  ReviewCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 评测
 */
@interface ReviewCell : BaseCell
/// 评测缩略图
@property (weak, nonatomic) IBOutlet UIImageView *reviewHeadImageView;
/// 评测标题
@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLable;
/// 评测描述
@property (weak, nonatomic) IBOutlet UILabel *reviewDescribeLable;
@property (weak, nonatomic) IBOutlet UILabel *reviewTypeLable;
/**
 *  类型字体颜色
 */
@property(nonatomic,strong)UIColor * typeColor;
@end
