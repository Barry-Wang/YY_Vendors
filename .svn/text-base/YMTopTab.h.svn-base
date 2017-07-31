//
//  YMTopTab.h

//
//  Created by barryclass on 10/17/14.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YMTopTabAnimation) {
    
    YMTopTabSlide,
    YMTopTabBigger
};

@protocol YMTopTabDelegate <NSObject>

-(void)changeToPage:(NSInteger)page;

@end


@interface YMTopTab : UIView <UIScrollViewDelegate>

/*
 @describ:初始化函数，返回一个YMTopTab
 @param: point  YMTopTab 的位置
 @param: array  显示的标题数组
 @param: font   title的字体
 */

NS_ASSUME_NONNULL_BEGIN

//- (id)initWithOrigin:(CGPoint)origin tabsArray:(NSArray *)array titleFont:(UIFont*) font maxFont:(UIFont *)maxFont;
- (id)initWithOrigin:(CGPoint)origin tabsArray:(NSArray *)array titleFont:(UIFont*) font maxFont:(UIFont *)maxFont animationStyle:(YMTopTabAnimation)animation;


// 默认选择第几个tab,默认选择第一个
@property (nonatomic, assign) NSInteger selected;

//标题的字体，这个字体会决定整个topTab的高度
@property (nonatomic, strong) UIFont    *font;

// 滑动条的颜色，默认为黄色
@property (nonatomic, strong) UIColor   *slideColor;

// 适配的可滚动的scrollView
@property (nonatomic, strong) UIScrollView *adpterScrollView;

//非选中状态颜色
@property (nonatomic, strong) UIColor      *unselectColor;


// 选中状态颜色


@property (nonatomic, strong) UIColor   *selectColor;

@property (nonatomic, assign) CGFloat   height;

@property (nonatomic, assign) CGFloat   titleWidth;

@property (nonatomic, strong) UIColor   *slideBackGroundColor;

@property (nonatomic, strong) UIFont    *maxFont;

@property (nonnull, assign) id<YMTopTabDelegate>delegate;
@property (nonatomic, assign) YMTopTabAnimation tabAnimation;

@property (nonatomic, assign) CGFloat   preContentOffSetX;          // 跟据当前的跟pre 判断向哪个方向滚动

@property (nonatomic, strong) UIView  *maskView;                          // 滑动条

-(void)scrollToIndex:(NSInteger)index;

//要实现滑动ScrollView时必须在 ScrollView 的ScrollViewDidScroll 中调用 adapterScrollViewScroll
//在ScrollViewDidEndDecelerating  中调用   adapterScrollViewDidEndDecelerating
- (void)layoutSubviews;
- (void)adapterScrollViewScroll:(UIScrollView *)scrollView;
- (void)adapterScrollViewDidEndDecelerating:(UIScrollView *)scrollView;


NS_ASSUME_NONNULL_END

@end
