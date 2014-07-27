//  Created by Jason Morrissey

#import "JMTabView.h"

@interface CustomTabItem : JMTabItem 

@property (nonatomic,retain) UIImage * alternateIcon;


@property (nonatomic) CGFloat customWidth;

+ (CustomTabItem *)tabItemWithTitle:(NSString *)title icon:(UIImage *)icon alternateIcon:(UIImage *)icon;

@end
