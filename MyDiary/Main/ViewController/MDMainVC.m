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
#import "MDContactsVC.h"
#import "MDMemoVC.h"

@interface MDMainVC ()<UITableViewDelegate,UITableViewDataSource,MDEditUserDelegate,MDContactsDelegate,MDMemoDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;//头像按钮
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;//顶部背景图
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;//底部搜索框
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;//底部设置按钮

@property (strong, nonatomic) NSMutableArray * data;//数据源
@property (strong, nonatomic) NSMutableArray * cellImgArray;//cell左侧图标
@property (strong, nonatomic) NSString * contactsNum; //联系人数量
@property (strong, nonatomic) NSString * diaryNum; //日记数量
@property (strong, nonatomic) NSString * memoNum; //注意事项数量

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
    
    //联系人数量
    NSNumber * contactsNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"contactsNum"];
    self.contactsNum = contactsNumber == nil ? @"0" : [contactsNumber stringValue];
    
    //日记数量
    NSNumber * diaryNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"diarysNum"];
    self.diaryNum = diaryNumber == nil ? @"0" : [diaryNumber stringValue];

    //注意事项数量
    NSNumber * memoNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"memoNum"];
    self.memoNum = memoNumber == nil ? @"0" : [memoNumber stringValue];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kMDThemeChangeNotification" object:nil];
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
    vc.headImg = self.headBtn.imageView.image;
    vc.userName = self.nameLabel.text;
    vc.delegate = self;
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
    
    return 3;
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
    
    //图标
    UIImageView * img = (UIImageView *)[cell viewWithTag:1000];
    img.image = [UIImage imageNamed:self.cellImgArray[indexPath.row]];
    
    //标题
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:2000];
    titleLabel.text = self.data[indexPath.row];
    
    //数量
    UILabel * numberLabel = (UILabel *)[cell viewWithTag:3000];
    if (indexPath.row == 0) {
        //联系人数量
        numberLabel.text = self.contactsNum;
    }
    else if (indexPath.row == 1) {
        //日记数量
        numberLabel.text = self.diaryNum;
    }
    else{
        //注意事项数量
        numberLabel.text = self.memoNum;
    }
    
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 ){
        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MDContactsVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDContactsVC"];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    else if (indexPath.row == 1){
        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MDDiaryMainVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDDiaryMainVC"];
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    else{
        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MDMemoVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDMemoVC"];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //删除
    UITableViewRowAction * deleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"将删除该分类下所有项目,且不可恢复\n确定要继续吗" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            tableView.editing = NO;
        }];
        
        UIAlertAction * exitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            tableView.editing = NO;
            NSLog(@"删除");
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:exitAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
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
    
    return NO;
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
    
    //读取用户信息文件
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * userInfoPath = [path stringByAppendingPathComponent:@"userInfo.plist"];
    NSDictionary * userInfo = [NSDictionary dictionaryWithContentsOfFile:userInfoPath];
    
    //读取用户昵称
    self.nameLabel.text = [userInfo objectForKey:@"userName"] == nil ? @"Taki" : [userInfo objectForKey:@"userName"];
    
    //读取图片文件
    NSString * headImagePath = [path stringByAppendingPathComponent:@"pic_head_image"];
    NSData * imgData = [NSData dataWithContentsOfFile:headImagePath];
    UIImage * headImage = [UIImage imageWithData:imgData] == nil ? [UIImage imageNamed:@"ic_contacts_image_default"] : [UIImage imageWithData:imgData];
    [self.headBtn setImage:headImage forState:UIControlStateNormal];

}

#pragma mark MDEditUserDelegate 
- (void)editUserName:(NSString *)userName headImage:(UIImage *)headimage {
    
    [self.headBtn setImage:headimage forState:UIControlStateNormal];
    self.nameLabel.text = userName;
}

#pragma mark 懒加载
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray arrayWithObjects:@"紧急联络人",@"我的日记",@"注意事项", nil];
    }
    return  _data;
}

- (NSMutableArray *)cellImgArray {
    
    if (_cellImgArray == nil) {
        _cellImgArray = [NSMutableArray arrayWithObjects:@"ic_topic_contacts",@"ic_topic_diary",@"ic_topic_memo", nil];
    }
    return _cellImgArray;
}

#pragma mark MDContactsDelegate
- (void)updateContactsNumber:(NSString *)contactsNum {
    
    self.contactsNum = contactsNum;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark MDMemoDelegate
- (void)updateMemoNumber:(NSString *)memoNum {
    
    self.memoNum = memoNum;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
