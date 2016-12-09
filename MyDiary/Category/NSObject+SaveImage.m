//
//  NSObject+SaveImage.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "NSObject+SaveImage.h"

@implementation NSObject (SaveImage)

- (BOOL) saveImageToSandbox:(UIImage *)image fileName:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //图片文件的名称
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    return [UIImagePNGRepresentation(image) writeToFile: filePath atomically:YES];
}

@end
