//
//  MDTheme.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDTheme.h"

@implementation MDTheme
    
#pragma mark 单例
+ (instancetype)sharedInstance {
        static MDTheme * theme;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            theme = [[MDTheme alloc] init];
        });
        return theme;
}

//主题色
+ (UIColor *)themeColor {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * number = [userDefaults objectForKey:@"Theme"];
    
    if ([number integerValue] == 1 ) {
        return [[MDTheme sharedInstance] themeGirl];
    }
    return [[MDTheme sharedInstance] themeBoy];
    
}

+ (UIImage *)themeHomeHeaderImage {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * number = [userDefaults objectForKey:@"Theme"];
    
    if ([number integerValue] == 1 ) {
        return [[MDTheme sharedInstance] themeHomeHeaderGirlImage];
    }
    return [[MDTheme sharedInstance] themeHomeHeaderBoyImage];

}

+ (UIImage *)themeDiaryBackgroundImage {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * number = [userDefaults objectForKey:@"Theme"];
    
    if ([number integerValue] == 1 ) {
        return [[MDTheme sharedInstance] themeDiaryBackgroundGirlImage];
    }
    return [[MDTheme sharedInstance] themeDiaryBackgroundBoyImage];

}

+ (void)modifyNavigationBarColor {
    
    [[UINavigationBar appearance] setBarTintColor:[MDTheme themeColor]];
}

//主题蓝
- (UIColor *)themeBoy {
    
    return [UIColor colorWithRed:91/255.0 green:183/255.0 blue:228/255.0 alpha:1];
}

//主题粉
- (UIColor *)themeGirl {
    
    return [UIColor colorWithRed:238/255.0 green:115/255.0 blue:100/255.0 alpha:1];
}

//主题蓝 首页图片
- (UIImage *)themeHomeHeaderBoyImage {
    
    return [UIImage imageNamed:@"profile_theme_bg_taki"];
}
//主题粉 首页图片
- (UIImage *)themeHomeHeaderGirlImage {
    
    return [UIImage imageNamed:@"profile_theme_bg_mitsuha"];
}

//主题蓝 Diary背景图片
- (UIImage *)themeDiaryBackgroundBoyImage {
    return [UIImage imageNamed:@"theme_bg_taki"];
}
//主题粉 Diary背景图片
- (UIImage *)themeDiaryBackgroundGirlImage {
    return [UIImage imageNamed:@"theme_bg_mitsuha"];
}

@end
