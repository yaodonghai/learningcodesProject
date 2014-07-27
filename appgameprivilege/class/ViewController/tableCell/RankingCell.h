//
//  RankingCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 9/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 排行榜 cell
 */
@interface RankingCell : BaseCell


@property (weak, nonatomic) IBOutlet UILabel *rankingNumberLable;
@property (weak, nonatomic) IBOutlet UIView *rankingNumberBrView;
@property (weak, nonatomic) IBOutlet UIImageView *rankingIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *rankingNameLable;
@property (weak, nonatomic) IBOutlet UILabel *rankingtimeLable;
@property (weak, nonatomic) IBOutlet UIButton *rankingfocusButton;
@property (weak, nonatomic) IBOutlet UIView *brView;
@end
