//
//  MDDiaryMainVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryMainVC.h"
#import "MDTheme.h"
#import "MDEntriesVC.h"
#import "MDDiaryVC.h"
#import "MDCalendarVC.h"

@interface MDDiaryMainVC ()
    
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;//背景图片
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UILabel *diaryLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn; //返回按钮

@property (strong, nonatomic) MDEntriesVC * entriesVC;
@property (strong, nonatomic) MDCalendarVC * calendarVC;
@property (strong, nonatomic) MDDiaryVC * diaryVC;
    
@end

@implementation MDDiaryMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UISegmentedControl
    self.segmented.tintColor = [MDTheme themeColor];
    self.segmented.selectedSegmentIndex = 0;
    [self.segmented addTarget:self action:@selector(segmented:) forControlEvents:UIControlEventValueChanged];
    
    self.diaryLabel.textColor = [MDTheme themeColor];
    
    //背景图片
    self.backgroundImg.image = [MDTheme themeDiaryBackgroundImage];
    
    //UIScrollView
    self.mainScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 3, self.mainScrollView.frame.size.height);
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.scrollEnabled = NO;
    
    //初始化子视图
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.entriesVC = [sb instantiateViewControllerWithIdentifier:@"MDEntriesVC"];
    self.entriesVC.view.frame = CGRectMake(0, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
    [self.mainScrollView addSubview:self.entriesVC.view];
    [self addChildViewController:self.entriesVC];
    
    //返回按钮
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//返回按钮
- (void)backBtn:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//选项卡
- (void)segmented:(UISegmentedControl *)seg {
    
    if (seg.selectedSegmentIndex == 0) {
        
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    else if (seg.selectedSegmentIndex == 1) {
        
        if (self.calendarVC == nil) {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.calendarVC = [sb instantiateViewControllerWithIdentifier:@"MDCalendarVC"];
            self.calendarVC.view.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
            [self.mainScrollView addSubview:self.calendarVC.view];
            [self addChildViewController:self.calendarVC];
        }

        [self.mainScrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width, 0)];
    }
    else{
        
        if (self.diaryVC == nil) {
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.diaryVC = [sb instantiateViewControllerWithIdentifier:@"MDDiaryVC"];
            self.diaryVC.view.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * 2, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height);
            [self.mainScrollView addSubview:self.diaryVC.view];
            [self addChildViewController:self.diaryVC];
        }
        
        [self.mainScrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width * 2, 0)];
    }
}
    
@end
