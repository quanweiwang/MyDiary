//
//  MDMemoVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@protocol MDMemoDelegate <NSObject>

- (void) updateMemoNumber:(NSString *) memoNum;

@end

@interface MDMemoVC : BaseTableVC

@property (assign, nonatomic) id<MDMemoDelegate> delegate;

@end
