//
//  GameOrderAppView.h
//  appgameprivilege
//
//  Created by 姚东海 on 26/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  预约 view
 */
@interface GameOrderAppView : UIView<UITextFieldDelegate>
/**
 *  提示lable
 */
@property(nonatomic,strong)UILabel * orderLable;
/**
 *  邮箱 Field
 */
@property(nonatomic,strong)UITextField * orderemmailField;

/**
 *  QQ Field
 */
@property(nonatomic,strong)UITextField * orderqqField;

/**
 *  提交 uibutton
 */
@property(nonatomic,strong)UIButton * ordersubmitButton;

/**
 *  是否输入
 */
@property(nonatomic,assign)BOOL isinput;
@end
