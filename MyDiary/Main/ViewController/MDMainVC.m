//
//  MDMainVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDMainVC.h"
#import "MDDiaryMainVC.h"
#import "MDTheme.h"
#import "MDEditUserProfileVC.h"
#import "MDAsync.h"

@interface MDMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;//头像按钮
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;//顶部背景图
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;//底部搜索框
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;//底部设置按钮

@end

@implementation MDMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //头像按钮点击事件
    [self.headBtn addTarget:self action:@selector(headBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取用户信息
    [self read_userInfo];
    
    //顶部背景图
    self.backgroundImg.image = [MDTheme themeHomeHeaderImage];
    
    //设置按钮
    self.settingBtn.tintColor = [MDTheme themeColor];
    [self.settingBtn setImage:[[UIImage imageNamed:@"ic_settings_white_36dp"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    //输入框
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 18)];
    leftView.image = [UIImage imageNamed:@"ic_search_white_18dp"];
    leftView.contentMode = UIViewContentModeCenter;

    self.searchTextField.backgroundColor = [MDTheme themeColor];
    self.searchTextField.leftView = leftView;
    self.searchTextField.leftViewMode=UITextFieldViewModeAlways;
    
    //主题变更通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeNotification:) name:@"kMDThemeChangeNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮点击事件
//头像按钮
- (void)headBtn:(UIButton *)btn {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MDEditUserProfileVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDEditUserProfileVC"];
    [self.navigationController pushViewController:vc animated:YES];
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
    
    return 2;
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
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 ){
        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MDDiaryMainVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDDiaryMainVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else{
        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MDDiaryMainVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDMemoVC"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
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

#pragma mark 主题变更通知
- (void) themeChangeNotification:(NSNotification *)info {
    
    self.searchTextField.backgroundColor = [MDTheme themeColor];
    self.settingBtn.tintColor = [MDTheme themeColor];
    self.backgroundImg.image = [MDTheme themeHomeHeaderImage];
}

#pragma mark 读取用户数据
- (void) read_userInfo {
    
    NSDictionary * userInfo = [MDAsync async_getUserInfo];
    if (userInfo == nil) {
        return;
    }
    
    NSString * imagePath = [userInfo objectForKey:@"headImageFilePath"];
    UIImage * headImage = [UIImage imageWithContentsOfFile:imagePath];
    [self.headBtn setImage:headImage forState:UIControlStateNormal];
    
    self.nameLabel.text = [userInfo objectForKey:@"userName"] == nil ? @"Taki" : [userInfo objectForKey:@"userName"];
}
@end
