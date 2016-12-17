//
//  MDContactsVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/11.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@protocol MDContactsDelegate <NSObject>

- (void) updateContactsNumber:(NSString *) contactsNum;

@end

@interface MDContactsVC : BaseTableVC
@property (assign, nonatomic) id<MDContactsDelegate> delegate;

@end
