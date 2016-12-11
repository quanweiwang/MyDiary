//
//  MDAddMemoVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/11.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAddMemoVC.h"
#import "MDTheme.h"

@interface MDAddMemoVC ()
@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//完成按钮
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;//备忘录输入框

@end

@implementation MDAddMemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBarView.backgroundColor = [MDTheme themeColor];
    
    //取消按钮
    [self.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //完成按钮
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.memoTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//取消按钮
- (void)cancelBtn:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//完成按钮
- (void)okBtn:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
