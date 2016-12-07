//
//  MDMemoVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDMemoVC.h"
#import "MDMemoMdl.h"
#import "NSAttributedString+MDDiary.h"

@interface MDMemoVC ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) UIButton * rightBarBtn;//导航右按钮
@property (strong, nonatomic) NSMutableArray * data;//数据源
@end

@implementation MDMemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航右按钮
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    MDMemoMdl * model = [[MDMemoMdl alloc] init];
    model.memoState = 0;
    model.memoString = @"aaaaa";
    [self.data addObject:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: - 按钮点击事件
- (void)rightBarBtn:(UIButton *) btn {
    
    btn.selected = !btn.selected;
    
    [self.table setEditing:btn.selected animated:YES];
}

#pragma mark - Table view data source
// 告诉tableview一共有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//当前组内几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.data.count;
}

//每行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//每行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellString = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellString];
    }
    
    MDMemoMdl * model = self.data[indexPath.row];
    UILabel * memoLabel = (UILabel*)[cell viewWithTag:1000];
    
    if (model.memoState == 1) {
        NSMutableAttributedString * a = [NSMutableAttributedString strikethrough:model.memoString];
        memoLabel.attributedText = [NSMutableAttributedString strikethrough:model.memoString];
    }
    else{
        memoLabel.text = model.memoString;
    }
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return tableView.editing;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", indexPath);
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MDMemoMdl * model = self.data[indexPath.row];
    if (model.memoState == 0) {
        model.memoState = 1;
    }
    else {
        model.memoState = 0;
    }
    
    //刷新
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark: - 懒加载
//导航右按钮
- (UIButton *)rightBarBtn {
    
    if (_rightBarBtn == nil) {
        _rightBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_rightBarBtn setImage:[UIImage imageNamed:@"ic_mode_edit_white_24dp"] forState:UIControlStateNormal];
        [_rightBarBtn setImage:[UIImage imageNamed:@"ic_mode_edit_cancel_white_24dp"] forState:UIControlStateSelected];
        [_rightBarBtn addTarget:self action:@selector(rightBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBarBtn;
}

- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
