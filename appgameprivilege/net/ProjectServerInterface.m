//
//  ProjectServerInterface.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ProjectServerInterface.h"

@implementation ProjectServerInterface
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiUrl = APPGAME_URL;
        self.apiPath = @"archives/category/hot-features";
    }
    return self;
}
@end
