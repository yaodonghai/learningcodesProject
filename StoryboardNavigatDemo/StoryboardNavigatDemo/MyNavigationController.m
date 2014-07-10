//
//  MyNavigationController.m
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "MyNavigationController.h"

@implementation MyNavigationController


#pragma mark 一个类只会调用一次

+ (void)initialize

{
    
    // 1.取出设置主题的对象
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2.设置导航栏的背景图片
    
    NSString *navBarBg = nil;
    float version=[[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version>=7.0 ) { // iOS7
        
        navBarBg = @"顶部导航栏.png";
        
        navBar.tintColor = [UIColor whiteColor];
        
    } else { // 非iOS7
        
        navBarBg = @"顶部导航栏.png";
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        
    }
    
    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"navFrame: %@",NSStringFromCGRect(navBar.frame));
    
    // 3.标题
    
    [navBar setTitleTextAttributes:@{
                                     
                                     UITextAttributeTextColor : [UIColor whiteColor]
                                     
                                     }];
    
 
    
}



//if (IOS7) { self.edgesForExtendedLayout = UIRectEdgeNone; //视图控制器，四条边不指定 self.extendedLayoutIncludesOpaqueBars = NO; //不透明的操作栏 self.modalPresentationCapturesStatusBarAppearance = NO; }
//    （1）self.automaticallyAdjustsScrollViewInsets = NO;






#pragma mark 控制状态栏的样式

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    //return UIStatusBarStyleDefault;//黑色
    
     return UIStatusBarStyleLightContent;
    
}
@end
