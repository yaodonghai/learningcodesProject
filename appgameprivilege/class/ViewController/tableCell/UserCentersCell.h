//
//  UserCentersCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 5/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseCell.h"
/*
 个人中心 cell
 */
@interface UserCentersCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *righttagimageview;

@end
