//
//  ForwardGameCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 22/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseCell.h"
/**
 *  期待新游戏
 */
@interface ForwardGameCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *forwardGameIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *forwardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *forwardTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *forwardfocusLable;
@property (weak, nonatomic) IBOutlet UILabel *rankingNumberLable;
@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;
@property (weak, nonatomic) IBOutlet UIView *rankingNumberBrView;
@end
