//
//  myFocusServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 5/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "myFocusServerInterface.h"

@implementation myFocusServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=myfocus";
    }
    return self;
}
@end
