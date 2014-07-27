//
//  BaseCell.m
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "BaseCell.h"
#import "ColorUtil.h"
@implementation BaseCell
@synthesize leftColorVarView;
@synthesize bottemlineColor;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
    }
    return self;
}



- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 *  cell bottem 颜色
 *
 *  @param abottemlineColor 颜色
 */
-(void)setBottemlineColor:(UIColor *)abottemlineColor{
    
    if (![self.bottemViewline isKindOfClass:[UIView class]]) {
        self.bottemViewline=[[UIView alloc]initWithFrame:CGRectMake(0,( self.frame.size.height-1), self.frame.size.width, 0.4)];
        self.bottemViewline.clipsToBounds=YES;
        [self.bottemViewline setAlpha:0.4];
        self.bottemViewline.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self.contentView addSubview:self.bottemViewline];
    }
    self.bottemViewline.backgroundColor=abottemlineColor;
}




/**
 *  颜色条
 *
 *  @param value 第几条cell
 */
- (void)setIndex:(NSUInteger)value
{
    
    if (![self.leftColorVarView isKindOfClass:[UIView class]]) {
        self.leftColorVarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, self.frame.size.height)];
        leftColorVarView.clipsToBounds=YES;
        self.leftColorVarView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
        self.leftColorVarView.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:self.leftColorVarView];
    }
    
    self.leftColorVarView.backgroundColor =[ColorUtil getColorWithIndex:value];
}


@end
