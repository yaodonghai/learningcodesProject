//
//  MoreAppCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 9/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseCell.h"
/**
 *  更多应用
 */
@interface MoreAppCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *moreAppIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *moreAppNameLable;
@property (weak, nonatomic) IBOutlet UIButton *moreAppOperationButton;


@end
