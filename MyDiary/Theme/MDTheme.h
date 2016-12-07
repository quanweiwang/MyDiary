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
+ (UIColor *) themeColor;
@end
