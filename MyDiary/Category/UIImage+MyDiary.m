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
    
    //先对图片压缩
    UIImage * compressImage = [UIImage compressImage:image];
    
    UIGraphicsBeginImageContextWithOptions(compressImage.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, compressImage.size.width, compressImage.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //剪裁
    CGContextClip(ctx);
    
    //将图片绘制上去
    [compressImage drawInRect:rect];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)image {
    
    //原图等比缩放
    CGFloat width = image.size.width / [UIScreen mainScreen].bounds.size.width;
    CGFloat height = image.size.height / [UIScreen mainScreen].bounds.size.height;
    
    CGFloat factor = fmax(width, height);
    
    //画布大小
    CGFloat newWidth = image.size.width / factor;
    CGFloat newheight = image.size.height / factor;
    CGSize newSize = CGSizeMake(newWidth, newheight);

    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newWidth, newheight)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //图像压缩
    NSData * imgData = UIImageJPEGRepresentation(newImage, 0.5);
    return [UIImage imageWithData:imgData];
}

@end
