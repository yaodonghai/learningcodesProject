//
//  AlerViewManager.m
//  ThreeKingdomsProject
//
//  Created by niko on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AlerViewManager.h"
#import <QuartzCore/QuartzCore.h>

#define tintWidth 120
#define tintHeight 80

@implementation AlerViewManager

//+ (AlerViewManager*)shareInstance 
//{
//    static id instanceObj = nil;
//    if(instanceObj != nil)
//        return instanceObj;
//    
//    instanceObj = [[AlerViewManager alloc] init];
//    return instanceObj;
//}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_timer invalidate];
    //[_timer release];
    //_timer = nil;
    
    //[_contentView release];
    //_contentView = nil;
    
    //[_progressTintView release];
    //_progressTintView = nil;
    
    //[super dealloc];
}


- (void)showOnlyWhiteIndicatorinView:(UIView*)rootView
{
    [self  dismissMessageView:rootView];
    rootView.userInteractionEnabled = NO;
    
    
    
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(ceilf(_progressTintView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_progressTintView.bounds.size.height/2 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    
    
    [_progressTintView addSubview:indicator];
    
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;
}

- (void)showOnlyGrayIndicatorinView:(UIView*)rootView
{
    [self  dismissMessageView:rootView];
    rootView.userInteractionEnabled = NO;
    
    
    
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(ceilf(_progressTintView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_progressTintView.bounds.size.height/2 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    
    
    [_progressTintView addSubview:indicator];
    
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;
}



- (void)showOnlyWhiteLargeIndicatorinView:(UIView*)rootView
{
    [self  dismissMessageView:rootView];
    rootView.userInteractionEnabled = NO;
    
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(ceilf(_progressTintView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_progressTintView.bounds.size.height/2 - 10 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    [_progressTintView addSubview:indicator];
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;
}

- (void)showWebMessageSendStateWithMessage:(NSString*)mes inView:(UIView*)rootView
{
    [self  dismissMessageView:rootView];
    rootView.userInteractionEnabled = NO;
    CGFloat  width  = tintWidth;
    CGFloat height = tintHeight;
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(ceilf(rootView.bounds.size.width/2 - width/2),
                                                            ceilf(rootView.bounds.size.height/2 - height/2 ) - 30,
                                                            width,
                                                            height)];
    [_contentView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    [_contentView.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [_contentView.layer setBorderWidth: 2.0];
    [_contentView.layer setCornerRadius:5.0f];
    [_contentView.layer setMasksToBounds:YES];
    [_progressTintView addSubview:_contentView];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(ceilf(_contentView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_contentView.bounds.size.height/4 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    [_contentView addSubview:indicator];
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               _contentView.bounds.size.height/2,
                                                               _contentView.bounds.size.width,
                                                               _contentView.bounds.size.height/2)];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:10]];
    [label setText:mes];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:label];
    //[label release];
    //label = nil;
}




- (void)showMessage:(NSString*)mes inView:(UIView*)rootView
{
    [self  dismissMessageView:rootView];
    rootView.userInteractionEnabled = NO;
    CGFloat  width  = tintWidth;
    CGFloat height = tintHeight;
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(ceilf(rootView.bounds.size.width/2 - width/2),
                                                                 ceilf(rootView.bounds.size.height/2 - height/2),
                                                                 width,
                                                                 height)];
    [_contentView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    [_contentView.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [_contentView.layer setBorderWidth: 2.0];
    [_contentView.layer setCornerRadius:5.0f];
    [_contentView.layer setMasksToBounds:YES];
    [_progressTintView addSubview:_contentView];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(ceilf(_contentView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_contentView.bounds.size.height/4 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    [_contentView addSubview:indicator];
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               _contentView.bounds.size.height/2,
                                                               _contentView.bounds.size.width,
                                                               _contentView.bounds.size.height/2)];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:10]];
    [label setText:mes];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:label];
    //[label release];
    //label = nil;
}

- (void)showWebMessageLoadState:(UIView*)rootView
{
    [self dismissMessageView:rootView];
    CGFloat  width  = 50;
    CGFloat height = 50;
    
//    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
//    [_progressTintView setBackgroundColor:[UIColor clearColor]];
//    [rootView addSubview:_progressTintView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(ceilf(rootView.bounds.size.width/2 - width/2),
                                                            ceilf(rootView.bounds.size.height/2 - height/2),
                                                            width,
                                                            height)];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    [_contentView.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [_contentView.layer setBorderWidth: 2.0];
    [_contentView.layer setCornerRadius:5.0f];
    [_contentView.layer setMasksToBounds:YES];
//    [_progressTintView addSubview:_contentView];

    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicator.frame = CGRectMake(ceilf(_contentView.bounds.size.width/2 - indicator.bounds.size.width/2),
                                 ceilf(_contentView.bounds.size.height/4 - indicator.bounds.size.height/2),
                                 indicator.bounds.size.width,
                                 indicator.bounds.size.height);
    [_contentView addSubview:indicator];
    [indicator startAnimating];
    //[indicator release];
    //indicator = nil;

    
    [rootView addSubview:_contentView];
    
    _contentView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView beginAnimations:@"webShow" context:nil];
    [UIView setAnimationDuration:0.3];
    _contentView.transform = CGAffineTransformMakeScale(1.0,1.0);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];

}


- (void)dismissMessageView:(UIView*)rootView
{
//    if(rootView)
//    {
        rootView.userInteractionEnabled = YES;
        [_progressTintView removeFromSuperview];
        //[_progressTintView release];
        //_progressTintView = nil;
        
        [_contentView removeFromSuperview];
        //[_contentView release];
        //_contentView = nil;
//    }
}

- (void)showOnlyMessage:(NSString*)mes inView:(UIView*)rootView
{
    [self dismissMessageView:rootView];
    CGFloat  width  = tintWidth;
    CGFloat height = tintHeight;
    
    _progressTintView = [[UIView alloc] initWithFrame:rootView.bounds];
    [_progressTintView setBackgroundColor:[UIColor clearColor]];
    [rootView addSubview:_progressTintView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(ceilf(rootView.bounds.size.width/2 - width/2),
                                                                   ceilf(rootView.bounds.size.height/2 - height/2),
                                                                   width,
                                                                   height)];
    [_contentView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    [_contentView.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [_contentView.layer setBorderWidth: 2.0];
    [_contentView.layer setCornerRadius:5.0f];
    [_contentView.layer setMasksToBounds:YES];
    [_progressTintView addSubview:_contentView];
    
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = _progressTintView.bounds;
    [button addTarget:self action:@selector(dismissOnlyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_progressTintView addSubview:button];
    
    CGSize labelSize = [mes sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(_contentView.frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat labelHeight = labelSize.height + 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3,(_contentView.frame.size.height - labelHeight)/2,_contentView.bounds.size.width,
                                                              labelHeight)];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setText:mes];
    
    label.numberOfLines = 0;
    
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [_contentView addSubview:label];
    //[label release];
    //label = nil;

    _contentView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:0.3];
    _contentView.transform = CGAffineTransformMakeScale(1.0,1.0);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)dismissOnlyViewAction:(id)sender
{
    [self dismissOnlyMessageView];
}

- (void)dismissOnlyMessageView
{
    [_timer invalidate];
    //[_timer release];
    //_timer = nil;
    [UIView beginAnimations:@"dismiss" context:nil];
    [UIView setAnimationDuration:0.3];
    _contentView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [_timer invalidate];
    //[_timer release];
    //_timer = nil;
    
    if([animationID isEqualToString:@"show"])
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 
                                                  target:self
                                                selector:@selector(dismissOnlyMessageView)
                                                userInfo:nil repeats:NO];
    }
    if([animationID isEqualToString:@"webShow"])
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 
                                                   target:self
                                                 selector:@selector(dismissOnlyMessageView)
                                                 userInfo:nil repeats:NO];
    }
    else if([animationID isEqualToString:@"dismiss"])
    {
        [self dismissMessageView:nil];
    }
}



@end
