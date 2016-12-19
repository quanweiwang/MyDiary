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

//存储备忘录
+ (void)async_saveMemo:(NSMutableArray *)memo;

//存储联系人
+ (void)async_saveContacts:(NSMutableArray *)contacts;

//读取联系人
+ (NSMutableArray *)async_readContacts;

//读取备忘录
+ (NSMutableArray *)async_readMemo;
@end
