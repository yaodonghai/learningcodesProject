//
//  MyNavigationController.m
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "MyNavigationController.h"
#import <QuartzCore/QuartzCore.h>

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadLayerWithImage
{
    
    UIGraphicsBeginImageContext(self.visibleViewController.view.bounds.size);
    [self.visibleViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [animationLayer setContents: (id)viewImage.CGImage];
    [animationLayer setHidden:NO];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    animationLayer = [CALayer layer] ;
    CGRect layerFrame = self.view.frame;
    layerFrame.size.height = self.view.frame.size.height-self.navigationBar.frame.size.height;
    layerFrame.origin.y = self.navigationBar.frame.size.height+20;
    animationLayer.frame = layerFrame;
    animationLayer.masksToBounds = YES;
    [animationLayer setContentsGravity:kCAGravityBottomLeft];
    [self.view.layer insertSublayer:animationLayer atIndex:0];
    animationLayer.delegate = self;
    
    
}
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id<CAAction> action = (id)[NSNull null];
    return action;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect layerFrame = self.view.bounds;
    layerFrame.size.height = self.view.bounds.size.height-self.navigationBar.frame.size.height;
    layerFrame.origin.y = self.navigationBar.frame.size.height+20;
    animationLayer.frame = layerFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:animationLayer atIndex:0];
    if(animated)
    {
        [self loadLayerWithImage];
        
        UIView * toView = [viewController view];
        
        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform = CATransform3DMakeTranslation(self.view.frame.size.width, 0, 0);
        [Animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
        [Animation setDuration:0.3];
        Animation.delegate = self;
        Animation.removedOnCompletion = NO;
        Animation.fillMode = kCAFillModeBoth;
        
        [toView.layer addAnimation:Animation forKey:@"fromRight"];
        
        
        CABasicAnimation *Animation1  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform1 = CATransform3DIdentity;
        rotationAndPerspectiveTransform1.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
        [Animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [Animation1 setDuration:0.3];
        Animation1.delegate = self;
        Animation1.removedOnCompletion = NO;
        Animation1.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:Animation1 forKey:@"scale"];
    }
    [super pushViewController:viewController animated:NO];
}



-(UIViewController*)popViewControllerAnimated:(BOOL)animated
{
    [animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:animationLayer above:self.view.layer];
    if(animated)
    {
        [self loadLayerWithImage];
        
        UIView * toView = [[self.viewControllers objectAtIndex:[self.viewControllers indexOfObject:self.visibleViewController]-1] view];
        
        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform = CATransform3DMakeTranslation(self.view.frame.size.width, 0, 0);
        [Animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [Animation setDuration:0.3];
        Animation.delegate = self;
        Animation.removedOnCompletion = NO;
        Animation.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:Animation forKey:@"scale"];
        
        
        CABasicAnimation *Animation1  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform1 = CATransform3DIdentity;
        rotationAndPerspectiveTransform1.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
        [Animation1 setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [Animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [Animation1 setDuration:0.3];
        Animation1.delegate = self;
        Animation1.removedOnCompletion = NO;
        Animation1.fillMode = kCAFillModeBoth;
        [toView.layer addAnimation:Animation1 forKey:@"scale"];
        
    }
    return [super popViewControllerAnimated:NO];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [animationLayer setContents:nil];
    [animationLayer removeAllAnimations];
    [self.visibleViewController.view.layer removeAllAnimations];
    
    
}



@end
