//
//  ProjectCell.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ProjectCell.h"

@implementation ProjectCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setViewLayerWithRadius:(CGFloat)radius AndBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor*)borderColor{
    
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
    self.layer.borderWidth=borderWidth;
    self.layer.borderColor=borderColor.CGColor;
}






@end
