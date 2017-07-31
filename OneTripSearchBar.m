//
//  OneTripSearchBar.m
//  onetrip
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 rehulu. All rights reserved.
//

#import "OneTripSearchBar.h"

@interface OneTripSearchBar ()<UITextFieldDelegate>

@end

@implementation OneTripSearchBar

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
    
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            for (UIView *subview in view.subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"UITextField")]) {
                    UITextField *textField = (UITextField *) subview;
                    CGRect frame = textField.frame;
                    frame.size.height = 50;
                    textField.frame = frame;
                    textField.textColor = [UIColor whiteColor];
                    textField.font = [UIFont boldSystemFontOfSize:16];
                    textField.layer.masksToBounds = YES;
                    textField.layer.cornerRadius = 0.5;
                    textField.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.20];
                    textField.delegate = self;
                    textField.clearsOnBeginEditing = NO;
                    NSString *holderText = OT_PLACEHOLDER;
                    NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc] initWithString:holderText];
                    [placeHolder addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, holderText.length)];
                    textField.attributedPlaceholder = placeHolder;
                    
                    
                    for (UIView *searchImage in subview.subviews) {
                        if ([searchImage isKindOfClass:NSClassFromString(@"UIImageView")]) {
                            if (searchImage.frame.size.width == 13) {
                                UIImageView *imageView = (UIImageView *) searchImage;
                                CGRect frame = imageView.frame;
                                frame.size = CGSizeMake(20, 20);
                                imageView.frame = frame;
                                imageView.image = [UIImage imageNamed:@"OTSearch"];
                            }
                        }
                       
                    }
                    
                      break;
                }
              
            }
            break;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
    return YES;
}

@end
