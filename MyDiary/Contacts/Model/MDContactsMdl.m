//
//  MDContactsMdl.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/14.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDContactsMdl.h"

@implementation MDContactsMdl

#pragma mark 写入文件

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

#pragma mark 从文件中读取
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    
    return self;
}

@end
