//
//  MDTheme.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDTheme : NSObject
    
+ (instancetype)sharedInstance;
    
//主题色
+ (UIColor *)themeColor;

//首页头部 图片
+ (UIImage *)themeHomeHeaderImage;

//Diary背景图片
+ (UIImage *)themeDiaryBackgroundImage;

//更改导航栏颜色
+ (void)modifyNavigationBarColor;

@end
