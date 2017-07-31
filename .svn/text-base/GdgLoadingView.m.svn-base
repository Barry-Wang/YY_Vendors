//
//  GdgLoadingView.m
//  RehuluChest
//
//  Created by WangWei on 19/4/16.
//  Copyright © 2016年 Rehulu. All rights reserved.
//

#import "GdgLoadingView.h"
//#import  "AnimatedGif.h"
//#import "UIImageView+AnimatedGif.h"
@interface GdgLoadingView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy)void(^retry)(void);
@property (nonatomic, strong) UILabel *failLabel;
@property (nonatomic, strong) UIImageView *failImageView;

@end
@implementation GdgLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:imageView];
        [imageView setImage:[UIImage imageNamed:@"waiting"]];
        imageView.frame = CGRectMake(0, 0, 100, 25);
        self.imageView = imageView;
        imageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [self addSubview:self.imageView];
        self.imageView.hidden = YES;
        
        self.failImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
        self.failImageView.image = [UIImage imageNamed:@"Load failure"];
        self.failImageView.center = CGPointMake(self.frame.size.width * 0.5, frame.size.height * 0.5 - 70);
        [self addSubview:self.failImageView];
        self.failImageView.hidden = YES;
       
        self.failLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.failImageView.frame) + 45, self.frame.size.width, 20)];
        self.failLabel.textColor = UIColorFromRGB(0x474747);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:OT_LOADINGFAILE];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x00a899) range:NSMakeRange(6,2)];
        self.failLabel.attributedText = str;
        self.failLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.failLabel];
        self.failLabel.hidden = YES;

        UITapGestureRecognizer *retryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retryLoad)];
        [self addGestureRecognizer:retryTap];
        
    }
    
    return self;
    
}


-(void)start {
    
    if (_hidLoadingView) {
        
        self.imageView.hidden = YES;

    } else {
    
        self.imageView.hidden = NO;
    }
    

    self.failLabel.hidden =  YES;
    self.failImageView.hidden = YES;
}

-(void)sucess {
    
    [self removeFromSuperview];
}

-(void)failureWihthRetry:(void(^)(void))retry {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.imageView.hidden = YES;
        self.failLabel.hidden = NO;
        self.failImageView.hidden = NO;
        self.retry = retry;
    });
    
}

-(void)retryLoad {
    
    self.imageView.hidden = NO;
    self.failLabel.hidden = YES;
    self.failImageView.hidden = YES;
    if (self.retry) {
        self.retry();
    }
}




@end
