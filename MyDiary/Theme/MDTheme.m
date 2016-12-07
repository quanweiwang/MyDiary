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
+ (UIColor *) themeColor {
    
    return [[MDTheme sharedInstance] themeBlue];
    
}
    
//主题蓝
- (UIColor *) themeBlue {
    
    return [UIColor colorWithRed:103/255.0 green:181/255.0 blue:230/255.0 alpha:1];
}
@end
