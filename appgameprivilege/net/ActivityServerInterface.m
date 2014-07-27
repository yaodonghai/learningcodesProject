//
//  ActivityServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 9/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ActivityServerInterface.h"

@implementation ActivityServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = SEVER_URL;
        self.apiPath = @"app_admin.php?g=Api&a=Api&f=huodongList";
    }
    return self;
}
@end
