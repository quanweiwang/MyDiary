//
//  BaseTableVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()
@property (strong, nonatomic) UIBarButtonItem * navBackBtn;
@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.navigationController.childViewControllers.count>1) {
        self.navBackBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pk_back_btn"] style:UIBarButtonItemStyleDone target:self action:@selector(navBackBtn:)];
        self.navigationItem.leftBarButtonItem = self.navBackBtn;
    }
    
    UIView * tableLine = [[UIView alloc]init];
    
    for (UIView * subView in self.view.subviews)
    {
        if ([subView isKindOfClass:[UITableView class]])
        {
            UITableView * tableView = (UITableView *)subView;
            //消除多余线条
            if(tableView.tableHeaderView == nil ){
                tableView.tableHeaderView = tableLine;
            }
            
            if (tableView.tableFooterView == nil ) {
                tableView.tableFooterView = tableLine;
            }
            
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navBackBtn:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
