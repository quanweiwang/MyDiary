//
//  MDMemoMdl.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDMemoMdl : NSObject
@property (assign, nonatomic) NSInteger memoState;//便签状态 0正常 1结束
@property (strong, nonatomic) NSString * memoString;//便签内容
@end
