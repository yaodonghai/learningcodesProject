//
//  Refreshview.m
//  frameworkDemo
//
//  Created by 姚东海 on 19/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "Refreshview.h"

@implementation Refreshview
@synthesize fefreshimageView=_fefreshimageView;
@synthesize refreshwebblock=_refreshwebblock;

/**
 *  放位置 刷新view
 *
 *  @param Poin 位置
 *
 *  @return 刷新view
 */
-(id)initWithRefreshviewFrame:(CGPoint)Poin{
    UIImage * image=[UIImage imageNamed:@"刷新动画image.png"];
    self=[self initWithFrame:CGRectMake(Poin.x, Poin.y, image.size.width, image.size.height)];
    if (self) {
        isload=NO;
        _fefreshimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(self.frame.size.width), (self.frame.size.height))];
        _fefreshimageView.image=image;
        [self addSubview:_fefreshimageView];
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer*  singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAnimation)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
    }
    return self;
}


- (void)move:(NSTimer *)timer
{
    CGFloat angel=thepa * (M_PI / 100.0f);
	CGAffineTransform transform=CGAffineTransformMakeRotation(angel);
	thepa=(thepa+1) % 200;
	float degree=1.0f;
	CGAffineTransform scaled=CGAffineTransformScale(transform, degree, degree);
	[_fefreshimageView setTransform:scaled];
}

/**
 *  开始转
 */
-(void)startAnimation{
    if (!isload) {
        _refreshwebblock(YES,self);
        [self start];
    }
}



/**
 *  开始
 */
-(void)start{
        if (!isload) {
            myTimer=[NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(move:) userInfo:nil repeats:YES];
            isload=YES;
        }
    
}

/**
 *  停止
 */
-(void)stop{
    [myTimer invalidate];
    CGFloat angel=0.0f;
	CGAffineTransform transform=CGAffineTransformMakeRotation(angel);
    CGAffineTransform scaled=CGAffineTransformScale(transform, 1.0f, 1.0f);
	[_fefreshimageView setTransform:scaled];
    thepa=0;
    isload=NO;
}
@end
