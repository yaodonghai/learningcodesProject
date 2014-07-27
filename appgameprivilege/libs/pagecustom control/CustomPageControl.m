//
//  CustomPageControl.m
//  appgameprivilege
//
//  Created by 姚东海 on 30/6/14.
//  Copyright (c) 2014年 appgame. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl
@synthesize selectedpage=_selectedpage;
@synthesize imageViews=_imageViews;
@synthesize selectedimage=_selectedimage;
@synthesize images=_images;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // Initialization code
    }
    return self;
}

/**
 *  自定义PageControl
 *
 *  @param frame     frame
 *  @param images    图片组
 *  @param curtimage 选中的图片
 *
 *  @return CustomPageControl
 */
-(id)initWithFrame:(CGRect)frame AddImageArray:(NSArray*)amages Withcurtimage:(UIImage*)curtimage{
    self=[self initWithFrame:frame];
    _imageViews= [[NSMutableArray alloc]init];
    _selectedpage=0;
    _images=amages;
    _selectedimage=curtimage;
    if (self) {
      
        if ([amages isKindOfClass:[NSArray class]]&&amages.count>0&&[curtimage isKindOfClass:[UIImage class]]) {

            float w=curtimage.size.width+8;
            float x=(self.frame.size.width-(w*amages.count))*0.5;
            float y=self.frame.size.height<curtimage.size.height?0:(self.frame.size.height-curtimage.size.height)*0.5;

            float h=self.frame.size.height>curtimage.size.height?curtimage.size.height:self.frame.size.height;
            for (UIImage * normalimage in amages) {
                UIImageView * imageview=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
                imageview.image=normalimage;
                imageview.highlightedImage=curtimage;
                imageview.contentMode =  UIViewContentModeCenter;
                [self addSubview:imageview];
                [_imageViews addObject:imageview];
                self.backgroundColor=[UIColor clearColor];
                x=imageview.frame.origin.x+imageview.frame.size.width;
                
            }
            [self selecteImage];
        }
        
        
    }
    return self;
}


-(void)selecteImage{
    
    for (int i=0;i<_imageViews.count;i++) {
        UIImageView * imageview=[_imageViews objectAtIndex:i];
        if (_selectedpage==i) {
            [imageview setHighlighted:YES];
        }else{
            [imageview setHighlighted:NO];
        }
        
    }
    
}


-(void)setSelectedpage:(int)aselectedpage{
    _selectedpage=aselectedpage;
    [self selecteImage];

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
