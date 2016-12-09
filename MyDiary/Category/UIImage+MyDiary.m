//
//  UIImage+MyDiary.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "UIImage+MyDiary.h"

@implementation UIImage (MyDiary)

+ (UIImage *)roundImage:(UIImage *)image {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //剪裁
    CGContextClip(ctx);
    
    //将图片绘制上去
    [image drawInRect:rect];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
