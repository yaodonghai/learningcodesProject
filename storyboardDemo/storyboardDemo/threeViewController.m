//
//  threeViewController.m
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "threeViewController.h"
#import "fourViewController.h"
@interface threeViewController ()

@end

@implementation threeViewController
@synthesize name;
@synthesize user;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (user) {
        self.titleLable.text=user.name;
    }
    // Do any additional setup after loading the view.
}

-(void)setUser:(UserData *)auser{
    user=auser;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)nextAction:(id)sender {
    
    //1.storyboard中定义某个独立newViewController（无segue跳转关系）的 identifier
    static  NSString *controllerId =@"fourViewController";
    //2.获取UIStoryboard对象
    UIStoryboard *story = [UIStoryboard  storyboardWithName:@"indedview"   bundle:nil];
   fourViewController  *nvc = [story instantiateViewControllerWithIdentifier:controllerId];
   nvc.data=@"hi";
    
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
    //3.从storyboard取得newViewCtroller对象，通过Identifier区分
    
//    
//    //4.对newViewController进行压栈实现tableview跳转到newTableview
//    [ [self navigationController] pushViewController:nvc   animated:YES ];
//    if([self navigationController] != nil)
//        NSLog(@"self.navigationController is not nil");
//    else {
//        NSLog(@"self.navigationController is nil");
//    }
//    
//    
}
@end
