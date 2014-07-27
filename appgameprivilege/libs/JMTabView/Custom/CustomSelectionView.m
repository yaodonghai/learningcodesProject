//  Created by Jason Morrissey

#import "CustomSelectionView.h"
#import "UIView+InnerShadow.h"
#import "UIColor+Hex.h"

#define kTriangleHeight 0.

@implementation CustomSelectionView

- (void)drawRect:(CGRect)rect
{
    //[[UIColor colorWithHex:0x252525] set];
//    [[UIColor colorWithRed:164./255 green:146./255 blue:149./255 alpha:1.0] set];
//    CGRect squareRect = CGRectOffset(rect, 0, kTriangleHeight);
//    squareRect.size.height -= kTriangleHeight;
//    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRoundedRect:squareRect cornerRadius:4.];
//    [squarePath fill];
//    
//    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
//    [trianglePath moveToPoint:CGPointMake(rect.size.width / 2 - kTriangleHeight, kTriangleHeight)];
//    [trianglePath addLineToPoint:CGPointMake(rect.size.width / 2, 0.)];
//    [trianglePath addLineToPoint:CGPointMake(rect.size.width / 2 + kTriangleHeight, kTriangleHeight)];
//    [trianglePath closePath];
//    [trianglePath fill];

//    UIImage *img = [UIImage imageNamed:@"当前状态.png"];
//    [img drawInRect:rect];
}

+ (CustomSelectionView *) createSelectionView;
{
    CustomSelectionView * selectionView = [[CustomSelectionView alloc] initWithFrame:CGRectZero];
    return selectionView;
}

@end
