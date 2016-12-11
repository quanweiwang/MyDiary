//
//  MDEditUserProfileVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@protocol MDEditUserDelegate <NSObject>

- (void)editUserName:(NSString *)userName headImage:(UIImage *)headimage;

@end

@interface MDEditUserProfileVC : BaseTableVC

@property (strong, nonatomic) UIImage *headImg; //头像
@property (strong, nonatomic) NSString * userName;//昵称
@property (assign, nonatomic) id<MDEditUserDelegate>delegate;
@end
