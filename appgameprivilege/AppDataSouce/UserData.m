//
//  UserData.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "UserData.h"
#import "config.h"
@implementation UserData
static UserData *_instance;

@synthesize username=_username,icon=_icon,mail=_mail,userid=_userid;
@synthesize gender=_gender;
-(id)init{
    self=[super init];
    if (self) {
      [self initdata];
    }
    return self;
}


+ (UserData *)shareInstance {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
          
        }
    }
    return _instance;
}


/**
 *  保存QQ个人信息
 */
-(void)saveUserinfo{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_username forKey:@"username"];
    [defaults setObject:_icon forKey:@"icon"];
    [defaults setObject:_gender forKey:@"gender"];
}

/**
 *  初始化
 */
-(void)initdata{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    _username=[defaults objectForKey:@"username"];
    _icon=[defaults objectForKey:@"icon"];
    _gender=[defaults objectForKey:@"gender"];

}

/**
 *  清用户信息
 */
-(void)clearuserinfo{
    _username=nil;
    _icon=nil;
    _gender=nil;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_username forKey:@"username"];
    [defaults setObject:_icon forKey:@"icon"];
    [defaults setObject:_gender forKey:@"gender"];
}
@end
