//
//  ProjectCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
/**
 专题 cell
 */
@interface ProjectCell : BaseCell
///专题缩略图
@property (weak, nonatomic) IBOutlet UIImageView *projectHeadImageView;
///专题标题
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLable;

///专题日期
@property (weak, nonatomic) IBOutlet UILabel *projectDateLable;

@end
