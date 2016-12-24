//
//  MDDiaryVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@protocol MDDiaryDelegate <NSObject>

- (void) diary_selectedSegmentIndex:(NSInteger) index;

@end

@interface MDDiaryVC : BaseTableVC

@property(assign, nonatomic) id<MDDiaryDelegate>delegate;

@end
