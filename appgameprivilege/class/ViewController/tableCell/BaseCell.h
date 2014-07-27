//
//  BaseCell.h
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  基类自定义 tablecell
 */
@interface BaseCell : UITableViewCell
@property(nonatomic,assign)NSUInteger index;
@property(nonatomic,strong)UIColor * bottemlineColor;
@property (nonatomic, strong) UIView *leftColorVarView;
@property(nonatomic,strong)UIView * bottemViewline;
@end
