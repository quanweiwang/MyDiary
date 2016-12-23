//
//  MDDiaryPickerVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/23.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryPickerVC.h"
#import "MDDiaryPickerCell.h"

@interface MDDiaryPickerVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//完成按钮
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *pickerViewBackgroundView;//背景视图
@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;//背景按钮

@property (assign, nonatomic) NSInteger didSelectRow;//当前选择下标
@property (assign, nonatomic) NSInteger inComponent;
@end

@implementation MDDiaryPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    //取消按钮
    [self.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //完成按钮
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    //背景按钮
    self.backgroundBtn.alpha = 0.3f;
    [self.backgroundBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.tag = self.tag;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.pickViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击时间
//取消按钮
- (void) cancelBtn:(UIButton *)btn {
    
    [self dismissView];
}

//完成按钮
- (void) okBtn:(UIButton *)btn {
    
    [self.delegate diary_pickerView:self.pickerView didSelectRow:self.didSelectRow inComponent:self.inComponent];
    [self dismissView];
}

#pragma mark UIPickerView相关
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.imageArray.count;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 44;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.didSelectRow = row;
    self.inComponent = component;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    MDDiaryPickerCell * diaryPickerCell = (MDDiaryPickerCell *)view;
    if (diaryPickerCell == nil) {
        diaryPickerCell = [[[NSBundle mainBundle] loadNibNamed:@"MDDiaryPickerCell" owner:nil options:nil] lastObject];
    }
    diaryPickerCell.image = [UIImage imageNamed:self.imageArray[row]];
    return diaryPickerCell;
}

//关闭视图
- (void) dismissView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.pickViewBottomConstraint.constant = -260;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
