//
//  OTTabBarController.m
//  onetrip
//
//  Created by mac on 17/3/25.
//  Copyright © 2017年 rehulu. All rights reserved.
//

#import "OTTabBarController.h"

@interface OTTabBarController ()

@end

@implementation OTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = 57;
    frame.origin.y = Main_Screen_Height - frame.size.height;
    self.tabBar.frame = frame;
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.barStyle = UIBarStyleDefault;
    }

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    for (NSInteger i = 0; i < 3 ; i++) {
        NSArray *array = [self.tabBar.subviews[i] subviews];
        for (id thing in array) {
            if ([thing isKindOfClass:[UIImageView class]]) {
                
            }
            if ([thing isKindOfClass:[UILabel class]]) {
                UILabel *label = thing;
                CGRect frame = label.frame;
                frame.size.height = 20;
                label.frame = frame;
                
            }
        }
        
    }
    
    //self.selectedIndex = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
