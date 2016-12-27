//
//  MDDiaryDetailVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/20.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseVC.h"
@class MDDiaryMdl;

@protocol MDDiaryDetailDelegate <NSObject>

@optional
- (void) deleteDiary:(NSIndexPath *)indexPath;
- (void) editDiary:(MDDiaryMdl *)model indexPath:(NSIndexPath *)indexPath;
@end

@interface MDDiaryDetailVC : BaseVC

@property (strong, nonatomic) NSIndexPath * indexPath; //日记列表下标
@property (strong, nonatomic) MDDiaryMdl * model;
@property (assign, nonatomic) id<MDDiaryDetailDelegate>delegate;

@end
