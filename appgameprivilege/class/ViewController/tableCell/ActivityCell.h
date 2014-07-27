//
//  ActivityCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 9/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 活动 cell
*/
@interface ActivityCell : BaseCell
@property (weak, nonatomic) IBOutlet UIImageView *activityHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *activityDescLable;
@property (weak, nonatomic) IBOutlet UIButton *activityInButton;
@property (weak, nonatomic) IBOutlet UILabel *activityLable1;
@property (weak, nonatomic) IBOutlet UILabel *activityLable2;
@property (weak, nonatomic) IBOutlet UIView *brView;
@property (weak, nonatomic) IBOutlet UILabel *activityactiontagLable;

@end
