//
//  MDAppDelegate.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDTheme.h"

@interface MDAppDelegate ()

@end

@implementation MDAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBarTintColor:[MDTheme themeColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //启动页放大效果 仿Twitter
    //获取rootView
    UIView * launchView = self.window.rootViewController.view;
    
    //给RootView 添加蒙版
    CALayer * launchLayer = [CALayer layer];
    launchLayer.bounds = CGRectMake(0, 0, 100, 100);
    launchLayer.position = launchView.center;
    launchLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
    launchView.layer.mask = launchLayer;
    
    //创建遮挡视图并添加到rootView
    UIView * shelterView = [[UIView alloc] initWithFrame:launchView.frame];
    shelterView.backgroundColor = [UIColor whiteColor];
    [launchView addSubview:shelterView];
    
    self.window.backgroundColor = [MDTheme themeColor];
    
    CAKeyframeAnimation * logoAnimation = [[CAKeyframeAnimation alloc] init];
    logoAnimation.keyPath = @"bounds";
    logoAnimation.beginTime = CACurrentMediaTime() + 1;
    logoAnimation.duration = 1;
    logoAnimation.keyTimes = @[@0, @0.4, @1];
    logoAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)],
                             [NSValue valueWithCGRect:CGRectMake(0, 0, 85, 85)],
                             [NSValue valueWithCGRect:CGRectMake(0, 0, 4500, 4500)]];
    logoAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [logoAnimation setRemovedOnCompletion:NO];
    logoAnimation.fillMode = kCAFillModeForwards;
    [launchLayer addAnimation:logoAnimation forKey:@"zoomAnimation"];
    
    CAKeyframeAnimation * mainViewAnimation = [[CAKeyframeAnimation alloc] init];
    mainViewAnimation.keyPath = @"transform";
    mainViewAnimation.beginTime = CACurrentMediaTime() + 1.1;
    mainViewAnimation.duration = 0.6;
    mainViewAnimation.keyTimes = @[@0, @0.5, @1];
    mainViewAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                 [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DIdentity]];

    [launchView.layer addAnimation:mainViewAnimation forKey:@"transformAnimation"];
    launchView.layer.transform = CATransform3DIdentity;
    
    [UIView animateWithDuration:0.3 delay:1.4 options:UIViewAnimationOptionCurveLinear animations:^{
        shelterView.alpha = 0;
    } completion:^(BOOL finished) {
        [shelterView removeFromSuperview];
        launchView.layer.mask = nil;
    }];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
