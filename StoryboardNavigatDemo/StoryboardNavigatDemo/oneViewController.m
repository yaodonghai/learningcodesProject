//
//  oneViewController.m
//  StoryboardNavigatDemo
//
//  Created by 姚东海 on 9/7/14.
//  Copyright (c) 2014年 zebra. All rights reserved.
//

#import "oneViewController.h"

@implementation oneViewController
- (IBAction)nextAction:(id)sender {
    
    [self performSegueWithIdentifier:@"threeview" sender:self];

}

@end
