//
//  GameDescribeScrollView.m
//  appgameprivilege
//
//  Created by 姚东海 on 26/5/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "GameDescribeScrollView.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+CustomLayer.h"
#import "global_defines.h"
@implementation GameDescribeScrollView
@synthesize curtGameItem;
@synthesize headview;
@synthesize gameimagesScrollView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  初始化游戏UI
 *
 *  @param frame fame
 *  @param item  游戏数据
 *
 *  @return GameDescribeScrollView 对象
 */
-(id)initWithFrame:(CGRect)frame AndGameItem:(GameItem*)item{
    self=[self initWithFrame:frame];
    if (self) {
        curtGameItem=item;
        if ([curtGameItem isMemberOfClass:[GameItem class]]) {
            [self bangData];
        }
    }
    return self;
}

/**
 *  游戏详情头 view
 */
-(void)creatviewUI{

    self.scrollEnabled=YES;
    self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator=NO;
    self.backgroundColor=[UIColor whiteColor];
    CGSize gamedetaisize=self.contentSize;
    self.contentSize=gamedetaisize;
    ///头部信息
     headview=[[GameDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
    headview=[[[NSBundle mainBundle] loadNibNamed:@"GameDetailHeadView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:headview];
    headview.gamenameLable.text=curtGameItem.gameName;
    
    if (curtGameItem.curtgametype==Rankingnew) {
        headview.gamedownnumberLalbe.text=[NSString stringWithFormat:@"已有%@ 人关注",curtGameItem.focuscount];

    }else {
        headview.gamedownnumberLalbe.text=[NSString stringWithFormat:@"已有%@ 人下载",curtGameItem.gameDowncount];

    }
    
    [ headview.gameiconImageView setImageWithURL:[NSURL URLWithString:curtGameItem.gameIcon] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
    [headview.gameiconImageView setdefaultLayer];
    [headview setViewbottemlineColor:[UIColor grayColor]];
    //空间
    float imagespace_w=15.0f;
    ///截图
    gameimagesScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(imagespace_w, (headview.frame.origin.y+headview.frame.size.height+10), (self.frame.size.width-imagespace_w*2), 214)];
    gameimagesScrollView.backgroundColor=[UIColor whiteColor];
    gameimagesScrollView.pagingEnabled=YES;
    gameimagesScrollView.scrollEnabled=YES;
    gameimagesScrollView.showsHorizontalScrollIndicator=NO;
    gameimagesScrollView.showsVerticalScrollIndicator=NO;
    [self addSubview:gameimagesScrollView];
    
//    UIImage * leftimage=[UIImage imageNamed:@"图标占位图.png"];
//    float lefttag_y=self.frame.origin.y+(gameimagesScrollView.frame.size.height*0.5)-(10*0.5);
//    UIImageView * lefttagimageView=[[UIImageView alloc]initWithFrame:CGRectMake(2, lefttag_y, 10, 10)];
//    lefttagimageView.image=leftimage;
//    [self addSubview:lefttagimageView];
//    UIImage * rightimage=[UIImage imageNamed:@"图标占位图.png"];
//    float right_x=self.frame.size.width-imagespace_w+2;
//    UIImageView * righttagimageView=[[UIImageView alloc]initWithFrame:CGRectMake(right_x, lefttag_y, 10, 10)];
//    righttagimageView.image=rightimage;
//    [self addSubview:righttagimageView];
    

    
    if ([curtGameItem.screenshots isKindOfClass:[NSMutableArray class]]&&curtGameItem.screenshots.count>0) {
        int  imagecount=curtGameItem.screenshots.count;
        int page=(imagecount/2)+(imagecount%2);
        gameimagesScrollView.contentSize=CGSizeMake(gameimagesScrollView.frame.size.width*page, gameimagesScrollView.frame.size.height);
        float image_w=(gameimagesScrollView.frame.size.width-imagespace_w)*0.5;
        float image_x=0.0;
        for (int i=0;i<curtGameItem.screenshots.count ;i++ ) {
            if ((i%2))image_x=image_x+imagespace_w;
            UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(image_x, 0.,image_w, gameimagesScrollView.frame.size.height)];
            imageView.clipsToBounds=YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView setImageWithURL:[NSURL URLWithString:curtGameItem.screenshots[i]] placeholderImage:[UIImage imageNamed:@"图标占位图.png"]];
            [gameimagesScrollView addSubview:imageView];
            image_x=imageView.frame.origin.x+image_w;
            
        }
    }
    
   
    //线
    UIView * bomttemlineView=[[UIView alloc]initWithFrame:CGRectMake(0, gameimagesScrollView.frame.origin.y+gameimagesScrollView.frame.size.height+10, self.frame.size.width, 0.6)];
    bomttemlineView.backgroundColor=RGBA(86, 86, 86,0.3);
    [self addSubview:bomttemlineView];
    
    if (curtGameItem.screenshots.count<=0) {
        CGRect bomttemlineViewFrame=bomttemlineView.frame;
        bomttemlineViewFrame.origin.y=gameimagesScrollView.frame.origin.y;
        bomttemlineView.frame=bomttemlineViewFrame;
//        [lefttagimageView setHidden:YES];
//        [righttagimageView setHidden:YES];
        [bomttemlineView setHidden:YES];
        [gameimagesScrollView setHidden:YES];
        [bomttemlineView setHidden:YES];
    }
   
    UILabel * GamenameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, bomttemlineView.frame.origin.y+bomttemlineView.frame.size.height+5, (self.frame.size.width-20), 20)];
    GamenameLable.backgroundColor=[UIColor clearColor];
    GamenameLable.text=[NSString stringWithFormat:@"《%@》详情介绍",curtGameItem.gameName];
    GamenameLable.textColor=RGB(86, 86, 86);
    GamenameLable.font=Font(15.0);
    [self addSubview:GamenameLable];
    
    //描述
    float content_y=GamenameLable.frame.origin.y+GamenameLable.frame.size.height+5;
    for (int i=0; i<5; i++) {
        NSString * contentstring=@"";
        if (i==0) {
            contentstring=@"游戏特色";
        }else if (i==1){
            contentstring=curtGameItem.gamedescribe;
        }else if (i==2){
            contentstring=[NSString stringWithFormat:@"更新 : %@",curtGameItem.gameDate];
        }else if (i==3){
            contentstring=[NSString stringWithFormat:@"版本 : %@",curtGameItem.gameVersion];
        }else if (i==4){
            contentstring=[NSString stringWithFormat:@"大小 : %@",curtGameItem.gameSize];
        }
        UILabel * GamecontentLable=[[UILabel alloc]initWithFrame:CGRectMake(10, content_y, GamenameLable.frame.size.width, 20)];
        GamecontentLable.textColor=[UIColor blackColor];
        GamecontentLable.textAlignment=NSTextAlignmentLeft;
        GamecontentLable.numberOfLines=0;
        GamecontentLable.backgroundColor=[UIColor clearColor];
        GamecontentLable.textColor=RGB(86, 86, 86);
        GamecontentLable.font=Font(13.0);
        GamecontentLable.text=contentstring;
        CGSize maximumSize =CGSizeMake(GamecontentLable.frame.size.width,9999);
        CGSize dateStringSize =[GamecontentLable.text sizeWithFont:GamecontentLable.font
                                                 constrainedToSize:maximumSize
                                                     lineBreakMode:GamecontentLable.lineBreakMode];
        CGRect dateFrame =GamecontentLable.frame;
        dateFrame.size.height=dateStringSize.height;
        GamecontentLable.frame = dateFrame;
        [self addSubview:GamecontentLable];
        content_y=content_y+dateStringSize.height+5;
        
    }
    gamedetaisize.height=content_y+20;
    self.contentSize=gamedetaisize;
}

/**
 *  绑定数据
 */
-(void)bangData{
    if (![curtGameItem isMemberOfClass:[GameItem class]]) {
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self creatviewUI];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
