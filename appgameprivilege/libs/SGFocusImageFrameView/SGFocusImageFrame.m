//
//  SGFocusImageFrame.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import "ArticleItem.h"
#import <objc/runtime.h>

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
 
- (void)setupViews;
- (void)switchFocusImageItems;
@end

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"com.touchmob.sgfocusitems";

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 3.0; //switch interval time

@implementation SGFocusImageFrame
@synthesize delegate = _delegate;
@synthesize run;



- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(ArticleItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        run=NO;
        NSMutableArray *imageItems = [NSMutableArray array];  
        ArticleItem *eachItem;
        va_list argumentList;
        if (firstItem)
        {                                  
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);       
            while((eachItem = va_arg(argumentList, ArticleItem *)))
            {
                [imageItems addObject: eachItem];            
            }
            va_end(argumentList);
        }
        
        objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self setupViews];
        
        [self setDelegate:delegate]; 
    }
    return self;
}



-(void)setDataSourcArray:(NSMutableArray*)imageItems setDelegate:(id<SGFocusImageFrameDelegate>)delegate{
    
    
    objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setupViews];
    
    [self setDelegate:delegate];
    
    
}



- (void)dealloc
{
    objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - private methods
- (void)setupViews
{
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    CGSize size = CGSizeMake(100, 20);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width *.5 - size.width *.5, self.bounds.size.height - size.height, size.width, size.height)];
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    UIImageView * bottemView=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, 320, 20)];
    bottemView.image=[UIImage imageNamed:@"preferential_add_botem_br.png"];
    [self addSubview:bottemView];
    [bottemView release];

//    _scrollView.layer.cornerRadius = 10;
//    _scrollView.layer.borderWidth = 1 ;
//    _scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl.numberOfPages = imageItems.count;
    _pageControl.currentPage = 0;
    
    _scrollView.delegate = self;
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * imageItems.count, _scrollView.frame.size.height);
    for (int i = 0; i < imageItems.count; i++) {
        ArticleItem *item = [imageItems objectAtIndex:i];
        //添加图片展示按钮
        UIImageView * imageView = [[UIImageView alloc] init];
        
       // [imageView setFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        
        UIView * imagecontentview=[[UIView alloc]initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        
        imagecontentview.clipsToBounds=YES;
        imagecontentview.contentMode = UIViewContentModeScaleAspectFill;

        imageView.frame=CGRectMake(0, 0, imagecontentview.frame.size.width, imagecontentview.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imagecontentview addSubview:imageView];
        [imageView release];
        
        [imageView setImageWithURL:item.articleIconURL placeholderImage:[UIImage imageNamed:@"图标占位图1.png"]];
        
       // imageView.image=[UIImage imageNamed:@"图标占位图.png"];
        //[imageView setImageWithURL:[NSURL URLWithString:item.imageurl]];
        //[imageView setImageWithURLAndDown:[NSURL URLWithString:item.imageurl] placeholderImage:[UIImage imageNamed:@"add_default_small_image.png"]];
        
     
        imageView.tag = i;
       
        [imageView setUserInteractionEnabled:NO];
        //添加点击事件
        //[imageView addTarget:self action:@selector(clickPageImage:) forControlEvents:UIControlEventTouchUpInside];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
//        imageView.image = item.image;
        //添加标题栏
//        UILabel * lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, _scrollView.frame.size.height-22.0, _scrollView.frame.size.width, 22.0)];
//        lbltitle.text = item.title;
//        lbltitle.backgroundColor = [UIColor clearColor];
//        
        [_scrollView addSubview:imagecontentview];
        [imagecontentview release];
        //[_scrollView addSubview:lbltitle];
        //[lbltitle release];
    }
    [tapGestureRecognize release];
    
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    if (run) {
         [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        
    }
   
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        ArticleItem *item = [imageItems objectAtIndex:page];
       
            if (_delegate) {
                [_delegate foucusImageFrame:self didSelectItem:item andwithIndex:page];

            }
       
    }
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
   // NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= _scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    _pageControl.currentPage = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    
}
#pragma mark - UIButtonTouchEvent
-(void)clickPageImage:(UIButton *)sender{
    
//    if (_delegate) {
//        [_delegate foucusImageFrame:self didSelectItem:item andwithIndex:page];
//
//    }

    NSLog(@"click button tag is %d",sender.tag);
}

@end
