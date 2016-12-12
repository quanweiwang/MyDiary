//
//  MDAddMemoVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/11.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseVC.h"
@class MDMemoMdl;

@protocol MDAddMemoDelegate <NSObject>

- (void)addMemo:(MDMemoMdl *)memoMdl;

@end

@interface MDAddMemoVC : BaseVC

@property (assign, nonatomic) id<MDAddMemoDelegate>delegate;

@end
