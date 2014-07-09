//
//  twoViewController.m
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "twoViewController.h"
#import "threeViewController.h"
#import "UserData.h"
@interface twoViewController ()

@end

@implementation twoViewController

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
    // Do any additional setup after loading the view.
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
    [self performSegueWithIdentifier:@"three" sender:self];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UserData * user=[[UserData alloc]init];
    
//    UIViewController * threeview=segue.destinationViewController;
    user.name=@"姚东海";
//    if ([threeview  respondsToSelector:@selector(setUser:)]) {
//        [threeview setValue:user forKey:@"user"];
//    }
    
    if([segue.identifier isEqualToString:@"three"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:user forKey:@"user"];
    }
    
}
@end
