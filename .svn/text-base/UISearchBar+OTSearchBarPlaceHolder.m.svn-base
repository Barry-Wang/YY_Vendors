//
//  UISearchBar+OTSearchBarPlaceHolder.m
//  onetrip
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 rehulu. All rights reserved.
//

#import "UISearchBar+OTSearchBarPlaceHolder.h"

@implementation UISearchBar (OTSearchBarPlaceHolder)

-(void)changeLeftPlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

@end
