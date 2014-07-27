//
//  GameOrderAppView.m
//  appgameprivilege
//
//  Created by 姚东海 on 26/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "GameOrderAppView.h"

@implementation GameOrderAppView
@synthesize orderemmailField,orderLable,orderqqField,ordersubmitButton;
@synthesize isinput;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creartui];
        // Initialization code
    }
    return self;
}


-(void)creartui{
    
    orderLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 25)];
    orderLable.backgroundColor=[UIColor clearColor];
    orderLable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:orderLable];
    orderLable.text=@"填写预约信息";
    UILabel *   tag1Lable=[[UILabel alloc]initWithFrame:CGRectMake(10, (orderLable.frame.origin.y+orderLable.frame.size.height+10), 60, 30)];
    tag1Lable.backgroundColor=[UIColor clearColor];
    [self addSubview:tag1Lable];
    tag1Lable.text=@"邮箱:";
    [self addSubview:tag1Lable];
    orderemmailField=[[UITextField alloc]initWithFrame:CGRectMake((tag1Lable.frame.origin.x+tag1Lable.frame.size.width), tag1Lable.frame.origin.y, (self.frame.size.width-tag1Lable.frame.origin.x+tag1Lable.frame.size.width-10), 25)];
    [self addSubview:orderemmailField];
    orderemmailField.delegate=self;
    orderemmailField.placeholder=@"输入邮箱地址";

    UILabel *   tag2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10, (orderemmailField.frame.origin.y+orderemmailField.frame.size.height+10), 60, 30)];
    tag2Lable.backgroundColor=[UIColor clearColor];
    [self addSubview:tag2Lable];
    tag2Lable.text=@"QQ:";
    [self addSubview:tag2Lable];
    orderqqField=[[UITextField alloc]initWithFrame:CGRectMake((tag2Lable.frame.origin.x+tag2Lable.frame.size.width), tag2Lable.frame.origin.y, (self.frame.size.width-tag2Lable.frame.origin.x+tag2Lable.frame.size.width-10), 25)];
    orderqqField.placeholder=@"输入QQ号";
    orderqqField.delegate=self;
    [self addSubview:orderqqField];
    
    UIImage * btnimage=[UIImage imageNamed:@""];
    ordersubmitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [ordersubmitButton setBackgroundImage:btnimage forState:UIControlStateNormal];
   // ordersubmitButton.frame=[CGRectMake((self.frame.size.width-btnimage.size.width)*0.5, (orderqqField.frame.origin.y+orderqqField.frame.size.height+10), btnimage.size.width, btnimage.size.height)];
       ordersubmitButton.frame=CGRectMake((self.frame.size.width-250)*0.5, (orderqqField.frame.origin.y+orderqqField.frame.size.height+10),250, 50);
    [ordersubmitButton setTitle:@"提交" forState:UIControlStateNormal];
    [ordersubmitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:ordersubmitButton];
    
}

// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
      return YES;
}

               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==self.orderemmailField) {
        [self.orderemmailField resignFirstResponder];
        [self.orderqqField becomeFirstResponder];
    }else if (textField==self.orderqqField){
        [self.orderqqField resignFirstResponder];
    }
    return YES;
}


-(void)setIsinput:(BOOL)aisinput{
    isinput=aisinput;
    if (self.orderqqField&&self.orderemmailField) {
        if (aisinput) {
            [self.orderqqField becomeFirstResponder];
        }else{
            [self.orderqqField resignFirstResponder];
            [self.orderemmailField resignFirstResponder];
        }
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
