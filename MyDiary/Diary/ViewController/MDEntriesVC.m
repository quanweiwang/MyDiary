//
//  MDEntriesVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDEntriesVC.h"
#import "MDTheme.h"
#import "MDDiaryDetailVC.h"
#import "MDDiaryMdl.h"
#import "MDAsync.h"

@interface MDEntriesVC ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;//菜单按钮
@property (weak, nonatomic) IBOutlet UIButton *addDiaryBtn;//写日记按钮
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;//相机按钮
@property (weak, nonatomic) IBOutlet UIView *bottomView;//底部视图

@property (strong, nonatomic) NSMutableArray * data;//数据源

@end

@implementation MDEntriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    //底部视图
    self.bottomView.backgroundColor = [MDTheme themeColor];
    
    //菜单按钮
    [self.menuBtn addTarget:self action:@selector(menuBtn:) forControlEvents:UIControlEventTouchUpInside];
    //写日记按钮
    [self.addDiaryBtn addTarget:self action:@selector(addDiaryBtn:) forControlEvents:UIControlEventTouchUpInside];
    //相机按钮
    [self.cameraBtn addTarget:self action:@selector(cameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(diaryNotification:) name:@"kMDDiaryNotification" object:nil];
    
    self.data = [MDAsync async_readDiary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//菜单按钮
- (void) menuBtn:(UIButton *)btn {
    
}
//写日记按钮
- (void) addDiaryBtn:(UIButton *)btn {
    
}
//相机按钮
- (void) cameraBtn:(UIButton *)btn {
    
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
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel * sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    sectionLabel.backgroundColor = [UIColor clearColor];
    sectionLabel.text = @"12";
    sectionLabel.textAlignment = NSTextAlignmentCenter;
    sectionLabel.textColor = [UIColor whiteColor];
    sectionLabel.font = [UIFont systemFontOfSize:24.0f];
    return sectionLabel;
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
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
    
    MDDiaryMdl * diaryMdl = self.data[indexPath.row];
    
    //天数
    UILabel * dayLabel = (UILabel *)[cell viewWithTag:1000];
    dayLabel.text = diaryMdl.day;
    
    //星期
    UILabel * weekdayLabel = (UILabel *)[cell viewWithTag:2000];
    weekdayLabel.text = diaryMdl.weekday;
    
    //时间
    UILabel * timeLabel = (UILabel *)[cell viewWithTag:3000];
    timeLabel.text = diaryMdl.time;
    
    //日记标题
    UILabel * diaryTitleLabel = (UILabel *)[cell viewWithTag:4000];
    diaryTitleLabel.text = diaryMdl.diaryTitle;
    
    //日记内容缩略
    UILabel * diaryContentLabel = (UILabel *)[cell viewWithTag:5000];
    diaryContentLabel.text = diaryMdl.diaryContent;
    
    //天气
    UIImageView * weatherImg = (UIImageView *)[cell viewWithTag:6000];
    weatherImg.image = [UIImage imageNamed:diaryMdl.weather];
    
    //心情
    UIImageView * moodImg = (UIImageView *)[cell viewWithTag:7000];
    moodImg.image = [UIImage imageNamed:diaryMdl.mood];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MDDiaryDetailVC * vc = [sb instantiateViewControllerWithIdentifier:@"MDDiaryDetailVC"];
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark MDDiaryNotification通知
- (void) diaryNotification:(NSNotification * )info {
    
    NSDictionary * dic = info.userInfo;
    MDDiaryMdl * diaryMdl = [dic objectForKey:@"diary"];
    [self.data addObject:diaryMdl];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
    [self.table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //存储日记
    [MDAsync async_saveDiary:self.data];
}

#pragma mark 懒加载
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
