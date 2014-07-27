//
//  UserCenterHeadView.m
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "UserCenterHeadView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppConfig.h"
#import "UIImageView+AFNetworking.h"
@implementation UserCenterHeadView
@synthesize isBorder;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
     
    }
    return self;
}

-(void)setIsBorder:(BOOL)aisBorder{
    if (aisBorder) {
        _userImageView.layer.cornerRadius=35.0;
        _userImageView.layer.masksToBounds=YES;
        _userImageView.layer.borderWidth=0.3;
        _userImageView.layer.borderColor=[UIColor grayColor].CGColor;
        
    }
    [self bottemline];
}

/**
 *  低线
 */
-(void)bottemline{
  
        UIView * bottemViewline=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.3, self.frame.size.width, 0.4)];
         bottemViewline.clipsToBounds=YES;
       bottemViewline.alpha=0.5;
      //  bottemViewline.autoresizingMask =UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:bottemViewline];

    bottemViewline.backgroundColor=[UIColor grayColor];
}


/**
 *  绑定个人信息
 */
-(void)bangUserData{
    
    if ([[AppConfig shareInstance].user.username isKindOfClass:[NSString class]]) {
        _userNameLable.text=[AppConfig shareInstance].user.username;
    }else{
        _userNameLable.text=@"";

    }
    
    if ([[AppConfig shareInstance].user.icon isKindOfClass:[NSString class]]) {
         [_userImageView setImageWithURL:[NSURL URLWithString:[AppConfig shareInstance].user.icon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
    }else{
        _userImageView.image=[UIImage imageNamed:@"图标占位图.png"];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
