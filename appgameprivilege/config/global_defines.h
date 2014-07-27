//
//  global_defines.h
//  TestAVOSPushDemo
//
//  Created by June on 14-4-3.
//  Copyright (c) 2014年 junewong. All rights reserved.
//

#ifndef TestAVOSPushDemo_global_defines_h
#define TestAVOSPushDemo_global_defines_h
#include "config.h"
#define LC(...) NSLocalizedString(__VA_ARGS__, __VA_ARGS__)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define Font(s)[UIFont fontWithName:@"Helvetica" size:(s)]
/**
 *  是否在线
 */
#define isLoginstate [[AppConfig shareInstance] isCheckLongin]

#endif
