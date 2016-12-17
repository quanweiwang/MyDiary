//
//  MDAddContactsVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/17.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDAddContactsVC.h"
#import "MDTheme.h"
#import "MDContactsMdl.h"

@interface MDAddContactsVC ()
@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;//背景按钮
@property (weak, nonatomic) IBOutlet UIView *popView;//弹窗视图
@property (weak, nonatomic) IBOutlet UIView *inputView;//输入框视图
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确认按钮
@property (weak, nonatomic) IBOutlet UILabel *contactsLabel;//联系人
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//用户名
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//密码

@end

@implementation MDAddContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //联系人
    self.contactsLabel.textColor = [MDTheme themeColor];
    
    //背景按钮
    self.backgroundBtn.alpha = 0.3;
    [self.backgroundBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    self.cancelBtn.layer.cornerRadius = 4.f;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //确认按钮
    self.okBtn.layer.cornerRadius = 4.f;
    self.okBtn.layer.masksToBounds = YES;
    self.okBtn.backgroundColor = [MDTheme themeColor];
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //弹窗视图
    self.popView.layer.cornerRadius = 8.f;
    
    //输入框视图
    self.inputView.layer.cornerRadius = 4.f;
    self.inputView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.inputView.layer.borderWidth = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//取消按钮
- (void)cancelBtn:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

//确认按钮
- (void)okBtn:(UIButton *)btn {
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        
    }
    else if ([self.phoneTextField.text isEqualToString:@""]) {
        
    }
    else{
        MDContactsMdl * model = [[MDContactsMdl alloc] init];
        model.name = self.nameTextField.text;
        model.phone = self.phoneTextField.text;
        [self.delegate addContacts:model];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

@end
