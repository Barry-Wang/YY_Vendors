//
//  OTGifHeader.m
//  onetrip
//
//  Created by mac on 17/3/25.
//  Copyright © 2017年 rehulu. All rights reserved.
//

#import "OTGifHeader.h"

@implementation OTGifHeader

- (void)prepare {
    [super prepare];
    
    [self setImages:@[[UIImage imageNamed:[NSString stringWithFormat:@"Load_0"]]] forState:MJRefreshStatePulling];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i <= 11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Load_%ld", (long)i]];
        [imageArray addObject:image];
    }
    [self setImages:imageArray forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    
}

@end
