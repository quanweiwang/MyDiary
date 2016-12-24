//
//  MDAsync.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAsync.h"
#import "NSObject+SaveImage.h"
#import "MDContactsMdl.h"

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

+ (void)async_saveMemo:(NSMutableArray *)memo {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 耗时的操作
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"memo.archiver"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }
        
        BOOL isSucceed = [NSKeyedArchiver archiveRootObject:memo toFile:path];
        
        if (isSucceed) {
            //存储联系人数量
            [[NSUserDefaults standardUserDefaults] setObject:@(memo.count) forKey:@"memoNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if (isSucceed) {
                NSLog(@"备忘录写入成功");
            }
            else{
                NSLog(@"备忘录写入失败");
            }
            
        });
        
    });
    
}

//存储联系人
+ (void)async_saveContacts:(NSMutableArray *)contacts {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 耗时的操作
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"contacts.archiver"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }
        
        BOOL isSucceed = [NSKeyedArchiver archiveRootObject:contacts toFile:path];
        
        if (isSucceed) {
            //存储联系人数量
            [[NSUserDefaults standardUserDefaults] setObject:@(contacts.count) forKey:@"contactsNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if (isSucceed) {
                NSLog(@"联系人写入成功");
            }
            else{
                NSLog(@"联系人写入失败");
            }
            
        });
    });
    
    
}

//存储联系人
+ (void)async_saveDiary:(NSMutableArray *)diarys {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 耗时的操作
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"diarys.archiver"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }
        
        BOOL isSucceed = [NSKeyedArchiver archiveRootObject:diarys toFile:path];
        
        if (isSucceed) {
            //存储日记数量
            [[NSUserDefaults standardUserDefaults] setObject:@(diarys.count) forKey:@"diarysNum"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if (isSucceed) {
                NSLog(@"日记写入成功");
            }
            else{
                NSLog(@"日记写入失败");
            }
            
        });
    });
    
    
}

//读取联系人
+ (NSMutableArray *)async_readContacts {
    
    // 耗时的操作
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"contacts.archiver"];
    
    //如果文件不存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
        
    {
        return nil;
    }
    
    NSMutableArray * contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
       
    return contacts;
}

//读取备忘录
+ (NSMutableArray *)async_readMemo {
    
    // 耗时的操作
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"memo.archiver"];
    
    //如果文件不存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
        
    {
        return nil;
    }
    
    NSMutableArray * memo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return memo;
}

//读取备忘录
+ (NSMutableArray *)async_readDiary {
    
    // 耗时的操作
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"diarys.archiver"];
    
    //如果文件不存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
        
    {
        return nil;
    }
    
    NSMutableArray * diarys = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return diarys;
}


@end
