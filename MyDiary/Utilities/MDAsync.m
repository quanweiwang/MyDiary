//
//  MDAsync.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAsync.h"
#import "NSObject+SaveImage.h"

@implementation MDAsync

+ (void)async_saveUserInfo:(UIImage *) userHeadImage userName:(NSString *) userName {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //存储图片
    dispatch_group_async(group, queue, ^{
        
        [[[MDAsync alloc] init] saveImageToSandbox:userHeadImage fileName:@"pic_head_image"];
    });
    
    //创建plist 注意iOS8起沙盒机制改变 请不要存储沙盒路径到数据库 plist等。每次启动文件夹名字都会改变。去读plist等存储的路径会取不到存储的资源
    dispatch_group_async(group, queue, ^{
        
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }
        
        NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
        if ([userName isEqualToString:@""] == NO && userName != nil) {
            [userInfo setObject:userName forKey:@"userName"];
        }
        
        [userInfo writeToFile:path atomically:YES];

    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"plist写入成功");
        });

    }); 
    
}

+ (void)async_saveMemo:(NSString *)memo {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 耗时的操作
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"Memo/memo.plist"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            NSLog(@"备忘录写入成功");
        });
    });
    
}

@end
