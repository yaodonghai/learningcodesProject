//
//  ProjectItem.h
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 专题 实体
 */
@interface ProjectItem : NSObject

///主题ID
@property(nonatomic,strong)NSString * projectId;
///标题
@property(nonatomic,strong)NSString * projectTitle;
///标题链接
@property(nonatomic,strong)NSString * projectUrl;
///缩略图
@property(nonatomic,strong)NSString * projectFirstThumbmail;
///第一张截图
@property(nonatomic,strong)NSString * projectFirstpic;
///发表时间
@property(nonatomic,strong)NSString * projectDate;
///主题类型
@property(nonatomic,strong)NSString * projectType;
///主题类型名称
@property(nonatomic,strong)NSString * projectTypeName;
///作者
@property(nonatomic,strong)NSString * projectCreator;
///描述
@property(nonatomic,strong)NSString * projectDesc;
///正文
@property(nonatomic,strong)NSString * projectContent
;
///来源
@property(nonatomic,strong)NSString * projectsource;

/**
 *  发步日期
 */
@property(nonatomic,strong)NSString * date;
///解析主题内容
-(id)initDic:(NSDictionary*)dictionary;
/**
 * 游戏资讯
 *
 *  @param dictionary DIC
 *
 *  @return
 */
-(id)initGameinformationDic:(NSDictionary*)dictionary;
;
@end
