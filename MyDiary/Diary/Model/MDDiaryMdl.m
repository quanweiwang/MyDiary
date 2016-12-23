//
//  MDDiaryMdl.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/23.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryMdl.h"

@implementation MDDiaryMdl

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    //月份
    [aCoder encodeObject:self.month forKey:@"month"];
    //天数
    [aCoder encodeObject:self.day forKey:@"day"];
    //时间
    [aCoder encodeObject:self.time forKey:@"time"];
    //星期
    [aCoder encodeObject:self.weekday forKey:@"weekday"];
    //国家
    [aCoder encodeObject:self.state forKey:@"state"];
    //市
    [aCoder encodeObject:self.city forKey:@"city"];
    //区
    [aCoder encodeObject:self.district forKey:@"district"];
    //日记标题
    [aCoder encodeObject:self.diaryTitle forKey:@"diaryTitle"];
    //日记内容
    [aCoder encodeObject:self.diaryContent forKey:@"diaryContent"];
    //天气
    [aCoder encodeObject:self.weather forKey:@"weather"];
    //心情
    [aCoder encodeObject:self.mood forKey:@"mood"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    //月份
    self.month = [aDecoder decodeObjectForKey:@"month"];
    //天数
    self.day = [aDecoder decodeObjectForKey:@"day"];
    //时间
    self.time = [aDecoder decodeObjectForKey:@"time"];
    //星期
    self.weekday = [aDecoder decodeObjectForKey:@"weekday"];
    //国家
    self.state = [aDecoder decodeObjectForKey:@"state"];
    //市
    self.city = [aDecoder decodeObjectForKey:@"city"];
    //区
    self.district = [aDecoder decodeObjectForKey:@"district"];
    //日记标题
    self.diaryTitle = [aDecoder decodeObjectForKey:@"diaryTitle"];
    //日记内容
    self.diaryContent = [aDecoder decodeObjectForKey:@"diaryContent"];
    //天气
    self.weather = [aDecoder decodeObjectForKey:@"weather"];
    //心情
    self.mood = [aDecoder decodeObjectForKey:@"mood"];
    
    return self;
}

@end
