//  Created by Jason Morrissey

#import <UIKit/UIKit.h>
#import "JMTabConstants.h"
#import "JMTabItem.h"
#import "JMSelectionView.h"
#import "JMTabContainer.h"

@class JMTabView;

#pragma Mark -
#pragma Mark - JMTabViewDelegate

@protocol JMTabViewDelegate <NSObject>
-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
@end

#pragma Mark -
#pragma Mark - JMTabView

@interface JMTabView : UIView {
    JMTabContainer * tabContainer;
}

- (void)setMomentary:(BOOL)momentary;
- (void)didSelectItemAtIndex:(NSUInteger)itemIndex;
- (void)addTabItem:(JMTabItem *)tabItem;
-(void)addTabItems:(NSArray*)tabItems;
- (void)addTabItemWithTitle:(NSString *)title icon:(UIImage *)icon;

- (void)removeTabItemAtIndex:(NSUInteger)index;
- (void)removeAllTabItems;

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic,assign) IBOutlet id<JMTabViewDelegate> delegate;
@property (nonatomic,assign) CGSize itemPadding;
@property (nonatomic,retain) JMTabContainer * tabContainer;

#if NS_BLOCKS_AVAILABLE
- (void)addTabItemWithTitle:(NSString *)title icon:(UIImage *)icon executeBlock:(JMTabExecutionBlock)executeBlock;
#endif

#pragma Mark -
#pragma Mark - Customisation

- (void)setSelectionView:(JMSelectionView *)selectionView;
- (void)setItemSpacing:(CGFloat)itemSpacing;
- (void)setBackgroundLayer:(CALayer *)backgroundLayer;


@end
