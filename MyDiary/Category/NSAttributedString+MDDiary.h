//
//  NSAttributedString+MDDiary.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (MDDiary)

/**
 *  富文本 带删除线文字
 *
 *  @param str   文字
 *
 *  @return 返回 富文本
 */
+(NSMutableAttributedString *) strikethrough:(NSString *)str;


@end
