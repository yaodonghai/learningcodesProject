//
//  DetailViewController.h
//  VerticalSwipeArticles
//
//  Created by Peter Boctor on 12/26/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "VerticalSwipeScrollView.h"

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate, VerticalSwipeScrollViewDelegate, UIWebViewDelegate>
{
    UIView* headerView;
    UIImageView* headerImageView;
    UILabel* headerLabel;

    UIView* footerView;
    UIImageView* footerImageView;
    UILabel* footerLabel;
  
    VerticalSwipeScrollView* verticalSwipeScrollView;
    NSArray* appData;
    NSUInteger startIndex, pageIndex;
    UIWebView* previousPage;
    UIWebView* nextPage;
    UIWebView* currentPage;
}

@property (nonatomic, retain) UIView* headerView;
@property (nonatomic, retain) UIImageView* headerImageView;
@property (nonatomic, retain) UILabel* headerLabel;
@property (nonatomic, retain) UIView* footerView;
@property (nonatomic, retain) UIImageView* footerImageView;
@property (nonatomic, retain) UILabel* footerLabel;
@property (nonatomic, retain) VerticalSwipeScrollView* verticalSwipeScrollView;
@property (nonatomic, retain) NSArray* appData;
@property (nonatomic) NSUInteger startIndex, pageIndex;
@property (nonatomic, retain) UIWebView* previousPage;
@property (nonatomic, retain) UIWebView* nextPage;
@property (nonatomic, retain) UIWebView* currentPage;

- (id)initWithTitle:(NSString *)title;

@end

