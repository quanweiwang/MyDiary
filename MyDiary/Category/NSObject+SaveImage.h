//
//  NSObject+SaveImage.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (SaveImage)

//保存图片到沙盒路径
- (BOOL) saveImageToSandbox:(UIImage *)image fileName:(NSString *)fileName;

@end
