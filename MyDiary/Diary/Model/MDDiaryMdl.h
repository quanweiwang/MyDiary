//
//  MDDiaryMdl.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/23.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDiaryMdl : NSObject<NSCoding>
@property (strong, nonatomic) NSString * month;//月份
@property (strong, nonatomic) NSString * day;//天数
@property (strong, nonatomic) NSString * time;//时间
@property (strong, nonatomic) NSString * weekday;//星期
@property (strong, nonatomic) NSString * state;//国家
@property (strong, nonatomic) NSString * city;//市
@property (strong, nonatomic) NSString * district;//区
@property (strong, nonatomic) NSString * diaryTitle;//日记标题
@property (strong, nonatomic) NSString * diaryContent;//日记内容
@property (strong, nonatomic) NSString * weather;//天气
@property (strong, nonatomic) NSString * mood;//心情
@end
