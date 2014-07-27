//
//  ProjectItem.m
//  appgameprivilege
//
//  Created by 姚东海 on 12/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "ProjectItem.h"

@implementation ProjectItem
@synthesize projectContent,projectCreator,projectDate,projectDesc,projectFirstpic,projectId,projectsource,projectFirstThumbmail,projectTitle,projectType,projectUrl;
@synthesize date;
@synthesize projectTypeName;

///解析主题内容
-(id)initDic:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]])return self;
       
        self.projectId=[dictionary objectForKey:@"id"];
        self.projectTitle=[dictionary objectForKey:@"title"];
        self.projectDesc=[dictionary objectForKey:@"title_plain"];
        self.projectUrl=[dictionary objectForKey:@"url"];
        //self.projectsource=[dictionary objectForKey:@"source"];
       // self.projectCreator=[dictionary objectForKey:@"author"];
        self.projectDate=[dictionary objectForKey:@"date"];
        self.projectFirstThumbmail=[dictionary objectForKey:@"thumbnail"];
        self.projectFirstpic=[dictionary objectForKey:@"date"];
        self.projectType=[dictionary objectForKey:@"type"];
        self.projectContent=[dictionary objectForKey:@"content"];
        self.date=[dictionary objectForKey:@"date"];
    }
    return self;
}


/**
 * 游戏资讯
 *
 *  @param dictionary DIC
 *
 *  @return 
 */
-(id)initGameinformationDic:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        if (![dictionary isKindOfClass:[NSDictionary class]])return self;
        
        //self.projectId=[dictionary objectForKey:@"id"];
        self.projectTitle=[dictionary objectForKey:@"title"];
        self.projectDesc=[dictionary objectForKey:@"intro"];
        self.projectUrl=[dictionary objectForKey:@"url"];
        self.projectTypeName=[dictionary objectForKey:@"typeName"];
        self.projectFirstThumbmail=[dictionary objectForKey:@"thumb"];
        self.projectType=[dictionary objectForKey:@"type"];
        projectDate=[dictionary objectForKey:@"add_time"];
        
    }
    return self;
}

@end
