//
//  ToastInputDataView.h
//  appgameprivilege
//
//  Created by 姚东海 on 23/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  弹入输入框
 */
@interface ToastInputDataView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *qqText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property(nonatomic,assign)float duration;
/**
 *  背景view
 */
@property(nonatomic,strong)UIView * toastBrView;
/**
 *  当前view fame
 */
@property(nonatomic,assign)CGRect toastFame;
/**
 *  显示
 */
-(void)showView;
/**
 *  隐藏
 */
-(void)hiddenView;

/**
 *  添加view
 *
 *  @param fatherView 父容器
 */
-(void)AddToastViewSubFatherView:(UIView*)fatherView;
@end
