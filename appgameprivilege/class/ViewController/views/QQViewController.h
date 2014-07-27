//
//  QQViewController.h
//  WGFrameworkDemo
//
//  Created by fly chen on 2/22/13.
//  Copyright (c) 2013 tencent.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QQViewController : UIViewController<UITextFieldDelegate>
{
    UILabel* _lbLog;
    UIButton *picImage;
    UITextField *verifyView;
}
-(void)setVerifyCode:(NSData *)data;
- (void)setLogInfo:(NSString *)string;
@property(nonatomic, retain)UILabel* lbLog;

@end
