//
//  threeViewController.m
//  StoryboardNavigatDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "threeViewController.h"

@implementation threeViewController

-(void)viewDidLoad{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
