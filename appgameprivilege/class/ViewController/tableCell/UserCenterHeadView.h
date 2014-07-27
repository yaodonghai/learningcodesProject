//
//  UserCenterHeadView.h
//  appgameprivilege
//
//  Created by 姚东海 on 21/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  个人中心headView
 */
@interface UserCenterHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
/**
 *  加边框
 */
@property(nonatomic,assign)BOOL isBorder;
/**
 *  绑定个人信息
 */
-(void)bangUserData;
@end
