//
//  ReviewCell.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ReviewCell.h"
#import "UIView+CustomLayer.h"
@implementation ReviewCell
@synthesize typeColor;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTypeColor:(UIColor *)atypeColor{
      [self.reviewTypeLable setViewLayerWithRadius:4.0 AndBorderWidth:0.8 AndBorderColor:atypeColor];
       self.reviewTypeLable.textColor=atypeColor;
}
@end
