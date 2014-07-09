//
//  fourViewController.h
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fourViewController : UIViewController
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property(nonatomic,strong)NSString * data;
@end
