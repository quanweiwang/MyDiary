//
//  BaseTableVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
