//
//  MDDiaryPickerVC.h
//  MyDiary
//
//  Created by 王权伟 on 2016/12/23.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseVC.h"

@protocol MDDiaryPickerDelegate <NSObject>

- (void) diary_pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface MDDiaryPickerVC : BaseVC

@property (copy, nonatomic) NSArray<NSString *> * imageArray;//图片数组 字符串
@property (assign, nonatomic) id<MDDiaryPickerDelegate>delegate;
@property (assign, nonatomic) NSInteger tag;
@end
