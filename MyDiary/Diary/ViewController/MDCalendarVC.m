//
//  MDCalendarVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDCalendarVC.h"
#import "MDTheme.h"

@interface MDCalendarVC ()

@property (weak, nonatomic) IBOutlet UIView *calendarView;//日历视图
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;//月份
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;//天数
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;//星期几

@property (strong, nonatomic) NSDate * date;//日期
@property (assign, nonatomic) NSInteger day;//天数

@property (strong, nonatomic) NSArray * monthArray;//月份数组
@property (strong, nonatomic) NSArray * weekdayArray;//星期数组
@end

@implementation MDCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    self.monthLabel.textColor = [MDTheme themeColor];
    self.dayLabel.textColor = [MDTheme themeColor];
    self.weekdayLabel.textColor = [MDTheme themeColor];
    
    self.date = [NSDate date];
    
    [self addSwipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 日历相关
//当前月份
- (NSString *)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    return self.monthArray[[components month] - 1];
}

//当前天数
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//今天星期几
- (NSString *)toDayInWeekday:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    [comp setDay:self.day];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return self.weekdayArray[firstWeekday - 1];
}

//前一天
- (NSDate *)lastDay:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//后一天
- (NSDate*)nextDay:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma mark 懒加载
- (void)setDate:(NSDate *)date {
    
    if (_date != date) {
        _date = date;
        //获取当前月份
        self.monthLabel.text = [self month:_date];
        //获取当前天数
        self.day = [self day:_date];
        self.dayLabel.text = [NSString stringWithFormat:@"%d",self.day];
        //获取当前星期几
        self.weekdayLabel.text = [self toDayInWeekday:_date];
    }
}

- (NSArray *)monthArray {
    
    if (_monthArray == nil) {
        _monthArray = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    }
    return _monthArray;
}

- (NSArray *)weekdayArray {
    
    if (_weekdayArray == nil) {
        _weekdayArray = [NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    }
    return _weekdayArray;
}

#pragma mark 手势
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.calendarView addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.calendarView addGestureRecognizer:swipRight];
}

- (void)previouseAction:(UIButton *)sender
{
    [UIView transitionWithView:self.calendarView duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastDay:self.date];
    } completion:nil];
}

- (void)nexAction:(UIButton *)sender
{
    [UIView transitionWithView:self.calendarView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextDay:self.date];
    } completion:nil];
}


@end
