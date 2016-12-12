//
//  MDAddMemoVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/11.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAddMemoVC.h"
#import "MDTheme.h"
#import "QWTextView.h"
#import "MDAsync.h"
#import "MDMemoMdl.h"

@interface MDAddMemoVC ()
@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//完成按钮
@property (weak, nonatomic) IBOutlet QWTextView *memoTextView;//备忘录输入框
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题

@end

@implementation MDAddMemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isEdit == YES) {
        self.titleLabel.text = @"编辑";
        
        self.memoTextView.text = self.memoStr;
    }
    else{
        self.titleLabel.text = @"写备忘";
    }
    
    self.navigationBarView.backgroundColor = [MDTheme themeColor];
    
    //取消按钮
    [self.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //完成按钮
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.memoTextView.placeholder = @"好记性不如烂笔头";
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
    
    [self.memoTextView resignFirstResponder];
    
    if ([self.memoTextView.text length] > 0) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未保存，是否现在退出" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * exitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];

        [alertController addAction:cancelAction];
        [alertController addAction:exitAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

//完成按钮
- (void)okBtn:(UIButton *)btn {
    
    [self.memoTextView resignFirstResponder];
    
    MDMemoMdl * model = [[MDMemoMdl alloc] init];
    model.memoState = 0;
    model.memoString = self.memoTextView.text;
    
    if (self.isEdit == YES) {
        
        [self.delegate editMemo:model indexPath:self.indexPath];
    }
    else{
        //异步存储
        [MDAsync async_saveMemo:self.memoTextView.text];
        
        [self.delegate addMemo:model];

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
