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

@optional
- (void)addMemo:(MDMemoMdl *)memoMdl;
- (void)editMemo:(MDMemoMdl *)memoMdl indexPath:(NSIndexPath *)indexPath;

@end

@interface MDAddMemoVC : BaseVC

@property (copy, nonatomic) NSIndexPath * indexPath;
@property (copy, nonatomic) NSString * memoStr;//备忘录内容
@property (assign, nonatomic) BOOL isEdit;//是否编辑状态 YES是 NO否
@property (assign, nonatomic) id<MDAddMemoDelegate>delegate;

@end
