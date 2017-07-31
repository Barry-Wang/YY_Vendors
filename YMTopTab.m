//
//  YMTopTab.m
//
//  Created by barryclass on 10/17/14.
//

#import "YMTopTab.h"

@interface YMTopTab()
@property (nonatomic, strong) UIScrollView *buttonContainer;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *buttonsArray;              // 存放字典有数组
@property (nonatomic, assign) CGFloat  parentWidth;                     // 屏幕宽度
@property (nonatomic, assign) CGPoint   origin;


@property (nonatomic, assign) CGFloat   titleDistance;                // 两个标题之间的距离
@property (nonatomic, assign) BOOL      needCaculateDistance;        // 是否需要重新计算两个title间的距离
@property (nonatomic, assign) CGFloat   dirction;                  // 1 正向  ， -1 反向
@property (nonatomic, assign) CGRect    tempRect;                 // 滚动前maskView 的frame
@property (nonatomic, assign) BOOL      isTap;                   // 是否是点击当前的页面
@property (nonatomic, assign) BOOL      hasSetTitleWidth;
@property (nonatomic, assign) CGFloat    grap;

@end

@implementation YMTopTab

- (id)initWithOrigin:(CGPoint)origin tabsArray:(NSArray *)array titleFont:(UIFont*) font maxFont:(UIFont *)maxFont animationStyle:(YMTopTabAnimation)animation
{

    self = [super init];
    if (self) {
        // Initialization code
        self.titleArray = array;
        self.origin = origin;
        self.needCaculateDistance = YES;
        self.titleDistance = 0.0f;
        self.preContentOffSetX = 0.0f;
        self.isTap = NO;
        self.selectColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        self.unselectColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.slideColor = [UIColor colorWithRed:234.0f / 255 green:97.0f / 255 blue:32.0f/ 255 alpha:1];
        self.slideBackGroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.hasSetTitleWidth = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.autoresizesSubviews = YES;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = self.slideColor;
        self.maskView = view;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.buttonContainer = scrollView;

        if (font == nil) {
            self.font = [UIFont systemFontOfSize:13];
        } else {
            self.font = font;
        }
        
        if (maxFont == nil) {
            self.maxFont = self.font;
        } else {
            self.maxFont = maxFont;
        }
        
        self. tabAnimation = animation;
        
        self.maskView.hidden = self.tabAnimation == YMTopTabBigger;
        
        self.selected = 0;

        
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    self.parentWidth = self.superview.frame.size.width;
    CGSize strSize = [@"topBar" sizeWithAttributes:@{ NSFontAttributeName : self.maxFont }];
    if (self.height == 0) {

        self.height = ceil(strSize.height) + 20;

    }
    CGRect   frame = CGRectMake(self.origin.x, self.origin.y, self.parentWidth, self.height);
    self.frame = frame;
    self.buttonContainer.backgroundColor = [UIColor clearColor];
    [self refreshTitle:self.titleArray];
    [self.superview setNeedsLayout];
}


- (void)refreshTitle:(NSArray *)titileArray {
    
    CGFloat  everyTitleWidth = 0.0f;
    
    if (self.hasSetTitleWidth == YES)
    {
        everyTitleWidth = self.titleWidth;
        self.grap = (self.parentWidth - self.titleArray.count * everyTitleWidth) / (self.titleArray.count + 1);
    } else {
        self.grap = 10;
    }
    
    for (UIView *view in self.buttonContainer.subviews) {
        [view removeFromSuperview];
    }
    self.buttonsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < self.titleArray.count; i++ ) {
        
        NSString *title = titileArray[i];
        
        UIButton *lastButton = [self.buttonsArray lastObject];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(lastButton.frame.origin.x + self.grap + lastButton.frame.size.width,4, 44,44);
        button.tag = i;
        [button setTitle:title  forState:UIControlStateNormal];
        UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeItem:)];
        [button addGestureRecognizer:tapRecongnizer];
        button.titleLabel.font = self.font;
        button.titleLabel.font = self.maxFont;
       
        if (i == self.selected) {

            [button.titleLabel setFont:self.maxFont];


        } else {
            
            [button setTitleColor:self.unselectColor forState:UIControlStateNormal];
            [button.titleLabel setFont:self.font];
        }
        CGRect buttonSize = button.frame;
        CGSize strSize = [title sizeWithAttributes:@{ NSFontAttributeName : self.maxFont}];
        
        buttonSize.size.height  = self.buttonContainer.frame.size.height;
        
        buttonSize.origin.y     = (self.frame.size.height - buttonSize.size.height)  / 2 ;
        if(self.hasSetTitleWidth == NO){
            everyTitleWidth = strSize.width + 10;
        }
        buttonSize.size.width   = everyTitleWidth;
        button.frame = buttonSize;
        [self.buttonsArray addObject:button];
        [self.buttonContainer addSubview:button];
        
//        if(i==0 && ){
//        
//            [button setTitleColor:self.selectColor forState:UIControlStateNormal];
//            [button.titleLabel setFont:self.maxFont];
//        }
    }
    
    UIButton *lastButton = self.buttonsArray.lastObject;
    
    // 如果不满足满屏时
    if (lastButton.frame.origin.x + lastButton.frame.size.width + 10  < self.parentWidth) {
        
        if (self.hasSetTitleWidth) {
            everyTitleWidth = self.titleWidth;
            self.grap = (self.parentWidth - self.buttonsArray.count * everyTitleWidth) / (self.buttonsArray.count + 1);
        } else {
            everyTitleWidth = 0;
            self.grap = 10;
        }
        [self.buttonsArray removeAllObjects];
        
        for (UIView *view in self.buttonContainer.subviews) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < self.titleArray.count; i++ ) {
            
            NSString *title = titileArray[i];
            lastButton = [self.buttonsArray lastObject];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(lastButton.frame.origin.x + self.grap + lastButton.frame.size.width, 0, self.titleWidth,0);
            button.tag = i;
            [button setTitle:title  forState:UIControlStateNormal];
            
            UITapGestureRecognizer *tapRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeItem:)];
            [button addGestureRecognizer:tapRecongnizer];
            button.titleLabel.font = self.font;
            
            if (i == self.selected) {
                
                [button.titleLabel setFont:self.maxFont];
                
                
            } else {
                
                [button setTitleColor:self.unselectColor forState:UIControlStateNormal];
                [button.titleLabel setFont:self.font];
            }
            
            CGRect buttonSize = button.frame;
            buttonSize.size.height  = self.buttonContainer.frame.size.height;
            buttonSize.origin.y     = (self.frame.size.height - buttonSize.size.height)  / 2;
            if (self.hasSetTitleWidth == NO) {
                
                
                everyTitleWidth =  (self.parentWidth - (titileArray.count + 1) * 10.0f) / titileArray.count;
            }
            buttonSize.size.width = everyTitleWidth;
            button.frame = buttonSize;
            [self.buttonsArray addObject:button];
            [self.buttonContainer addSubview:button];
        }
    }
    lastButton = [self.buttonsArray lastObject];
    self.buttonContainer.contentSize = CGSizeMake(lastButton.frame.origin.x + lastButton.frame.size.width + 10, 0);
    
    
    self.buttonContainer.backgroundColor = self.slideBackGroundColor;

    if (self.selected < self.buttonsArray.count) {
        
        UIButton *button =  self.buttonsArray[self.selected];
        [button setTitleColor:self.selectColor forState:UIControlStateNormal];
        self.maskView.frame = CGRectMake(button.frame.origin.x, self.buttonContainer.frame.size.height - 8,button.frame.size.width,3);
        self.maskView.layer.cornerRadius = 1;
        [self.buttonContainer addSubview:self.maskView];
    }

}


- (void)setAdpterScrollView:(UIScrollView *)adpterScrollView
{
    if (_adpterScrollView == adpterScrollView) {
        return;
    } else {
        
        if (adpterScrollView != nil) {
            _adpterScrollView = adpterScrollView;
        }
        
    }
}

- (void)changeItem:(UITapGestureRecognizer *) recongnizer
{
    UIButton *button = (UIButton *)recongnizer.view;
    self.selected = button.tag;
    self.isTap = YES;
    
    if (self.adpterScrollView != nil) {
        [self.adpterScrollView setContentOffset:CGPointMake(self.selected * self.adpterScrollView.frame.size.width, 0) animated:NO];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.adpterScrollView != nil) {
            [self.adpterScrollView setContentOffset:CGPointMake(self.selected * self.adpterScrollView.frame.size.width, 0) animated:NO];
        }
    } completion:^(BOOL finished) {
        self.isTap = NO;
    }];
    CGRect rect = self.maskView.frame;
    rect.origin.x = button.frame.origin.x;
    rect.size.width = button.frame.size.width;
    [UIView animateWithDuration:0.25f animations:^{
        self.maskView.frame =rect;
    }];
    
    
    self.preContentOffSetX = self.adpterScrollView.contentOffset.x;
    self.needCaculateDistance = YES;
    self.titleDistance = 0;
    if ([self.delegate respondsToSelector:@selector(changeToPage:)]) {
        [self.delegate changeToPage:self.selected];
    }
    
}

-(void)scrollToIndex:(NSInteger)index {
  
    [self changeItem:self.buttonsArray[index]];
}


- (void)setSelected:(NSInteger)selected {
    
    __block float fx = 0;
    UIButton *button = self.buttonsArray[selected];
    int dirction = selected > _selected ? 1 : -1;
    
    // button 的中心x减去contentOffsetX就是其在scrollView中的坐标，
    // - self.parentWidth / 2 表示其与中心点的距离。
    
    fx  = button.center.x - self.buttonContainer.contentOffset.x - self.parentWidth / 2;
    _selected = selected;
    [UIView animateWithDuration:0.15 animations:^{
        if (dirction == 1 && button.center.x - self.buttonContainer.contentOffset.x > self.parentWidth / 2 ) {
            fx = MIN(self.buttonContainer.contentOffset.x + fx, self.buttonContainer.contentSize.width - self.parentWidth);
            if (fx < 0) {
                fx = 0;
            }
            [self.buttonContainer setContentOffset:CGPointMake(fx,0)];
            
            
        } else if (dirction == -1 && button.center.x - self.buttonContainer.contentOffset.x < self.parentWidth / 2){
            fx = MAX(self.buttonContainer.contentOffset.x + fx, 0);
            [self.buttonContainer setContentOffset:CGPointMake(fx,0)];
        }
        
    }];
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *button = self.buttonsArray[i];
        if (i == selected) {
            
            if (self.tabAnimation == YMTopTabSlide) {
                
                [button setTitleColor:self.selectColor forState:UIControlStateNormal];
                if (self.maskView.frame.origin.x != button.frame.origin.x) {
                    CGRect rect = self.maskView.frame;
                    rect.origin.x = button.frame.origin.x;
                    rect.size.width = button.frame.size.width;
                    self.maskView.frame =rect;

                }
                
                [button.titleLabel setFont:self.maxFont];
                [button setTitleColor:self.selectColor forState:UIControlStateNormal];
                
            } else {
                
                [button.titleLabel setFont:self.maxFont];
                [button setTitleColor:self.selectColor forState:UIControlStateNormal];
                
                
            }

        } else {
            
            if (self.tabAnimation == YMTopTabSlide) {
                
                [button setTitleColor:self.unselectColor forState:UIControlStateNormal];
                [button.titleLabel setFont:self.font];
                [button setTitleColor:self.unselectColor forState:UIControlStateNormal];
                
            } else {
                
                [button.titleLabel setFont:self.font];
                [button setTitleColor:self.unselectColor forState:UIControlStateNormal];

            }

        }
        
        
    }
    
}
- (void)adapterScrollViewScroll:(UIScrollView *)scrollView
{
    
    if ( self.isTap == NO && scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < scrollView.contentSize.width - scrollView.frame.size.width) {
        if (self.needCaculateDistance == YES ) {
            
            
            CGFloat  dis = scrollView.contentOffset.x - self.preContentOffSetX;
            
            if (dis > 0 && self.selected < self.buttonsArray.count - 1) {
                UIButton *nextButton = self.buttonsArray[self.selected + 1];
                UIButton *currentButton = self.buttonsArray[self.selected];
                self.titleDistance =  nextButton.frame.origin.x - currentButton.frame.origin.x;
                self.dirction = 1;
            } else  if (dis < 0 && self.selected > 0){
                UIButton *preButton = self.buttonsArray[self.selected - 1];
                UIButton *currentButton = self.buttonsArray[self.selected];
                self.titleDistance = currentButton.frame.origin.x - preButton.frame.origin.x;
                self.dirction = -1;
            }
            
            self.needCaculateDistance = NO;
            self.tempRect = self.maskView.frame;
        }
        CGFloat percent =  fabs(scrollView.contentOffset.x - self.preContentOffSetX) / scrollView.frame.size.width;
        CGRect rect = self.tempRect;
        rect.origin.x += self.titleDistance * percent * self.dirction;
        
        UIButton *button = [self.buttonsArray lastObject];
        if (rect.origin.x > button.frame.origin.x) {
            rect.origin.x = button.frame.origin.x;
        }
        if (rect.origin.x < 0) {
            rect.origin.x = 0;
        }
        self.maskView.frame = rect;
    }
}
- (void)adapterScrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int kSelected =  ceil(scrollView.contentOffset.x / scrollView.frame.size.width);
    kSelected = kSelected > (int)self.titleArray.count - 1 ? (int)self.titleArray.count - 1 : kSelected;
    kSelected = kSelected < 0 ? 0 :kSelected;
     self.selected = kSelected;
    scrollView.contentOffset = CGPointMake(kSelected *scrollView.frame.size.width, 0);
    
    UIButton *button = self.buttonsArray[self.selected];
    CGRect rect = self.maskView.frame;
    rect.size.width = button.frame.size.width;
    self.maskView.frame = rect;
    
    self.preContentOffSetX = scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width ? scrollView.contentSize.width - scrollView.frame.size.width : scrollView.contentOffset.x;
    self.preContentOffSetX = self.preContentOffSetX  < 0 ? 0 : self.preContentOffSetX;
    self.needCaculateDistance = YES;
    self.titleDistance = 0;
    if([self.delegate respondsToSelector:@selector(changeToPage:)]) {
       
        [self.delegate changeToPage:self.selected];
    }
}


- (void)setSlideColor:(UIColor *)slideColor
{
    if (_slideColor != slideColor) {
        _slideColor = slideColor;
        self.maskView. backgroundColor =  slideColor;
    }
}

-(void)setSlideBackGroundColor:(UIColor *)slideBackGroundColor {
  
    _slideBackGroundColor = slideBackGroundColor;
    self.buttonContainer.backgroundColor = slideBackGroundColor;
}

- (void)setTitleWidth:(CGFloat)titleWidth
{
    if (_titleWidth != titleWidth) {
        _titleWidth = titleWidth;
        if (_titleWidth != 0) {
            self.hasSetTitleWidth = YES;
        } else {
            self.hasSetTitleWidth = NO;
        }
    }
}
@end

