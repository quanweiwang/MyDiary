//
//  MDAddContactsVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/17.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseVC.h"
@class MDContactsMdl;

@protocol MDAddContactsDelegate <NSObject>

- (void)addContacts:(MDContactsMdl *)contactsMdl;

@end

@interface MDAddContactsVC : BaseVC
@property (assign, nonatomic) id<MDAddContactsDelegate> delegate;

@end
