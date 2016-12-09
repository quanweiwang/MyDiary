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

#pragma mark 单例
+ (instancetype)sharedInstance {
    static MDAsync * theme;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theme = [[MDAsync alloc] init];
    });
    return theme;
}

+ (void)async_saveImage:(UIImage *)image fileName:(NSString *)fileName {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        BOOL isSave = [[MDAsync sharedInstance] saveImageToSandbox:image fileName:fileName];
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //通知主线程刷新
            NSLog(@"图片写入成功");
        });
        
    });
}

+ (void)async_saveUserInfo:(UIImage *) userHeadImage userName:(NSString *) userName {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //存储图片
    dispatch_group_async(group, queue, ^{
        
        [[MDAsync sharedInstance] saveImageToSandbox:userHeadImage fileName:@"pic_head_image.png"];
    });
    
    //创建plist
    dispatch_group_async(group, queue, ^{
        
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
        
        //如果文件不存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
            
        {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            
            [fileManager createFileAtPath:path contents:nil attributes:nil];
            
        }
        
        NSString * imageFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"pic_head_image.png"] == nil ? @"" : [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"pic_head_image.png"];
        
        NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:imageFilePath forKey:@"headImageFilePath"];
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

+ (NSDictionary *)async_getUserInfo {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        return nil;
    }
    
    NSDictionary * userInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    return userInfo;
}

@end
