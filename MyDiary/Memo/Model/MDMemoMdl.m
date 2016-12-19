//
//  MDMemoMdl.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDMemoMdl.h"

@implementation MDMemoMdl

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:@(self.memoState) forKey:@"memoState"];
    [aCoder encodeObject:self.memoString forKey:@"memoString"];
}

#pragma mark 从文件中读取
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    NSNumber * memoStateNumber = [aDecoder decodeObjectForKey:@"memoState"];
    self.memoState = [memoStateNumber integerValue];
    self.memoString = [aDecoder decodeObjectForKey:@"memoString"];
    
    return self;
}

@end
