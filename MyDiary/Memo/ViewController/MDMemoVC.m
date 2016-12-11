//
//  MDMemoVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDMemoVC.h"
#import "MDMemoMdl.h"
#import "MDTheme.h"
#import "MDAddMemoVC.h"

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

#pragma mark 按钮点击事件
- (void)rightBarBtn:(UIButton *) btn {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MDAddMemoVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDAddMemoVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark Table view data source
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
    
    //便签内容
    MDMemoMdl * model = self.data[indexPath.row];

    UILabel * memoLabel = (UILabel*)[cell viewWithTag:2000];
    memoLabel.textColor = [MDTheme themeColor];
    
    //memoState 0 正常 1 带删除线
    if (model.memoState == 1) {
        
        NSDictionary * attributeDic = @{NSStrikethroughStyleAttributeName : @1};
        memoLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:model.memoString attributes:attributeDic];
    }
    else{
        memoLabel.text = model.memoString;
    }

    
    
    //不要点击效果 不好看
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //删除
    UITableViewRowAction * deleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"删除");
    }];
    
    //编辑
    UITableViewRowAction * editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //事件
        NSLog(@"编辑");
    }];
    
    deleAction.backgroundColor = [UIColor redColor];
    editAction.backgroundColor = [UIColor orangeColor];
    return @[deleAction,editAction];
}
    
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", indexPath);
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //把状态变更
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

#pragma mark TableView 插入、删除效果
//插入一行
- (void)insertRows {
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}
    
//删除一行
- (void)deleteRows {
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}
    
#pragma mark 懒加载
//导航右按钮
- (UIButton *)rightBarBtn {
    
    if (_rightBarBtn == nil) {
        _rightBarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_rightBarBtn setImage:[UIImage imageNamed:@"ic_mode_edit_white_24dp"] forState:UIControlStateNormal];
        [_rightBarBtn addTarget:self action:@selector(rightBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBarBtn;
}

//数据源
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
