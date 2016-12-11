//
//  MDAsync.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDAsync : NSObject

//存储用户信息
+ (void)async_saveUserInfo:(UIImage *) userHeadImage userName:(NSString *) userName;

@end
