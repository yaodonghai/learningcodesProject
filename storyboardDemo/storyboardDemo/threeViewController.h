//
//  threeViewController.h
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
@interface threeViewController : UIViewController
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)UserData * user;
- (IBAction)nextAction:(id)sender;

@end
