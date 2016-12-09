//
//  BaseNav.m
//  QWNavDemoOC
//
//  Created by 王权伟 on 16/7/10.
//  Copyright © 2016年 wangqw. All rights reserved.
//

#import "BaseNav.h"

@interface BaseNav ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UIGestureRecognizerDelegate
    self.interactivePopGestureRecognizer.delegate = self;
    
    //UINavigationControllerDelegate
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //push 时关闭手势响应
    self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (navigationController.viewControllers.count == 1) {
        //如果是 rootViewController 就关闭手势响应
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    else{
        //如果不是 rootViewController 就开启手势响应
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
