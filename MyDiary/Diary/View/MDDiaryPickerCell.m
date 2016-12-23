//
//  MDDiaryPickerCell.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/23.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryPickerCell.h"

@interface MDDiaryPickerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MDDiaryPickerCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImage:(UIImage *)image {
    
    if (_image != image) {
        _image = image;
        self.imageView.image = _image;
    }
}

@end
