//
//  ViewController.m
//  storyboardDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)oneAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"oneview" sender:self];

}

- (IBAction)twoAction:(id)sender {
    [self performSegueWithIdentifier:@"twoView" sender:self];
}

- (IBAction)threeAction:(id)sender {
}
@end
