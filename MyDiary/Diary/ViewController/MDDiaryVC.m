//
//  MDDiaryVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/7.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryVC.h"
#import "QWTextView.h"
#import "MDTheme.h"
#import <CoreLocation/CoreLocation.h>
#import "MDDiaryPickerVC.h"
#import "MDDiaryMdl.h"

@interface MDDiaryVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate,MDDiaryPickerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;//月份
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;//天
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//星期 时间
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;//位置
@property (weak, nonatomic) IBOutlet UITextField *diaryTitleTextField;//日记标题
@property (weak, nonatomic) IBOutlet UIButton *weatherBtn;//天气按钮
@property (weak, nonatomic) IBOutlet UIButton *moodBtn;//心情按钮
@property (weak, nonatomic) IBOutlet QWTextView *diaryContentTextView;//日记内容
@property (weak, nonatomic) IBOutlet UIView *bottomView;//底部视图
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;//位置按钮
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;//相机按钮
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;//清空按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;//保存按钮
@property (weak, nonatomic) IBOutlet UIView *headView;//顶部视图
@property (weak, nonatomic) IBOutlet UIView *diaryLineView;//日记分割线

@property (strong, nonatomic) UIImagePickerController * picker;//相册&拍照
@property (strong, nonatomic) CLLocationManager* locationManager;//定位

@property (strong, nonatomic) NSArray * weekdayArray;//星期数组
@property (strong, nonatomic) NSArray * monthArray;//月份数组
@property (strong, nonatomic) NSArray<NSString *> * weatherArray;//天气数组
@property (strong, nonatomic) NSArray<NSString *> * moodArray;//心情数组
@property (strong, nonatomic) NSString * weekday;//星期
@property (strong, nonatomic) NSString * time;//时间
@property (strong, nonatomic) NSString * country;//国家
@property (strong, nonatomic) NSString * locality;//市
@property (strong, nonatomic) NSString * subLocality;//区
@property (assign, nonatomic) NSInteger weatherIndex;//天气下标
@property (assign, nonatomic) NSInteger moodIndex;//心情下标
@end

@implementation MDDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    //日记分割线
    self.diaryLineView.backgroundColor = [MDTheme themeColor];
    //底部视图
    self.bottomView.backgroundColor = [MDTheme themeColor];
    //顶部视图
    self.headView.backgroundColor = [MDTheme themeColor];
    //日记标题
    self.diaryTitleTextField.placeholder = @"日记标题";
    //日记内容
    self.diaryContentTextView.placeholder = @"在此写下您的日记内容";
    
    //天气按钮
    [self.weatherBtn addTarget:self action:@selector(weatherBtn:) forControlEvents:UIControlEventTouchUpInside];
    //心情按钮
    [self.moodBtn addTarget:self action:@selector(moodBtn:) forControlEvents:UIControlEventTouchUpInside];
    //位置按钮
    [self.locationBtn addTarget:self action:@selector(locationBtn:) forControlEvents:UIControlEventTouchUpInside];
    //相机按钮
    [self.cameraBtn addTarget:self action:@selector(cameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    //清空按钮
    [self.cleanBtn addTarget:self action:@selector(cleanBtn:) forControlEvents:UIControlEventTouchUpInside];
    //保存按钮
    [self.saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //当前 星期 时间
    NSDate * date = [NSDate date];
    self.weekday = [self toDayInWeekday:date];
    self.time = [self currentTime:date];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",self.weekday,self.time] ;
    //日期
    self.dayLabel.text = [NSString stringWithFormat:@"%d",[self day:date]];
    //月份
    self.monthLabel.text = [self month:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//天气按钮
- (void) weatherBtn:(UIButton *)btn {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MDDiaryPickerVC * weatherPicker = [sb instantiateViewControllerWithIdentifier:@"MDDiaryPickerVC"];
    weatherPicker.providesPresentationContextTransitionStyle = YES;
    weatherPicker.definesPresentationContext = YES;
    weatherPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    weatherPicker.delegate = self;
    weatherPicker.tag = 1;
    weatherPicker.imageArray = self.weatherArray;
    [self presentViewController:weatherPicker animated:NO completion:nil];

}
//心情按钮
- (void) moodBtn:(UIButton *)btn {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MDDiaryPickerVC * moodPicker = [sb instantiateViewControllerWithIdentifier:@"MDDiaryPickerVC"];
    moodPicker.providesPresentationContextTransitionStyle = YES;
    moodPicker.definesPresentationContext = YES;
    moodPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    moodPicker.delegate = self;
    moodPicker.tag = 2;
    moodPicker.imageArray = self.moodArray;
    [self presentViewController:moodPicker animated:NO completion:nil];
    
}
//位置按钮
- (void) locationBtn:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (btn.selected == YES) {
        
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            //最低精度即可
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                NSLog(@"requestAlwaysAuthorization");
                [self.locationManager requestAlwaysAuthorization];
            }
        }
        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];

    }
    else{
        //停止定位
        [self.locationManager stopUpdatingHeading];
    }
}
//相机按钮
- (void) cameraBtn:(UIButton *)btn {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"拍照&相册" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * photograph = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.picker animated:YES completion:nil];
        }
        else
        {
            NSLog(@"无摄像头，无法打开");
        }
        
        
    }];
    
    UIAlertAction * photoAlbum = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //相册选择
        if (self.picker == nil) {
            //初始化 相机
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.allowsEditing = YES;
        }
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:photograph];
    [alertController addAction:photoAlbum];
    [alertController addAction:cancel];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}
//清空按钮
- (void) cleanBtn:(UIButton *)btn {
    
    if ([self.diaryContentTextView.text length] != 0) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要清空日记内容吗" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        
        UIAlertAction * exitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            self.diaryContentTextView.text = @"";
            self.diaryTitleTextField.text = @"";
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:exitAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//保存按钮
- (void) saveBtn:(UIButton *)btn {
    
    if ([self.diaryTitleTextField.text length] == 0) {
        
    }
    else if ([self.diaryContentTextView.text length] == 0) {
        
    }
    else{
        
        MDDiaryMdl * diaryMdl = [[MDDiaryMdl alloc] init];
        diaryMdl.month = self.monthLabel.text;
        diaryMdl.day = self.dayLabel.text;
        diaryMdl.time = self.time;
        diaryMdl.weekday = self.weekday;
        diaryMdl.country = self.country;
        diaryMdl.locality = self.locality;
        diaryMdl.subLocality = self.subLocality;
        diaryMdl.diaryTitle = self.diaryTitleTextField.text;
        diaryMdl.diaryContent = self.diaryContentTextView.text;
        diaryMdl.weather = self.weatherArray[self.weatherIndex];
        diaryMdl.mood = self.moodArray[self.moodIndex];
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"kMDDiaryNotification" object:self userInfo:@{@"diary" : diaryMdl}];
        
        //切换到日记列表
        [self.delegate diary_selectedSegmentIndex:0];
        
    }
}

#pragma mark - 相机相关 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
    {
    
        
    }
    else
    {
        NSLog(@"Error media type");
    }
    
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 懒加载
- (UIImagePickerController *)picker {
    
    if (_picker == nil) {
        //初始化 相机
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
    }
    return _picker;
}

- (NSArray *)weekdayArray {
    
    if (_weekdayArray == nil) {
        _weekdayArray = [NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    }
    return _weekdayArray;
}

- (NSArray *)monthArray {
    
    if (_monthArray == nil) {
        _monthArray = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    }
    return _monthArray;
}

- (NSArray<NSString *> *)moodArray {
    
    if (_moodArray == nil) {
        _moodArray = [NSArray arrayWithObjects:@"ic_mood_happy",@"ic_mood_soso",@"ic_mood_unhappy", nil];
    }
    return _moodArray;
}

- (NSArray<NSString *> *)weatherArray {
    
    if (_weatherArray == nil) {
        _weatherArray = [NSArray arrayWithObjects:@"ic_weather_cloud",@"ic_weather_foggy",@"ic_weather_rainy",@"ic_weather_snowy",@"ic_weather_sunny",@"ic_weather_windy", nil];
    }
    return _weatherArray;
}

#pragma mark 定位相关
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [manager stopUpdatingLocation];
    
    //获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark * place = [placemarks lastObject];
        
        //国家
        self.country = place.country;
        //市
        self.locality = place.locality;
        //区
        self.subLocality = place.subLocality;
        
        self.locationLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.country, self.locality,self.subLocality];
       
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

#pragma mark 日期相关
//今天星期几
- (NSString *)toDayInWeekday:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    [comp setDay:[components day]];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return self.weekdayArray[firstWeekday - 1];
}

//当前时间
- (NSString *) currentTime:(NSDate *)date {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    
    return [dateFormatter stringFromDate:date];
}

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

#pragma mark MDDiaryPickerDelegate 相关
- (void)diary_pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView.tag == 1) {
        [self.weatherBtn setImage:[UIImage imageNamed:self.weatherArray[row]] forState:UIControlStateNormal];
        self.weatherIndex = row;
    }
    else{
        [self.moodBtn setImage:[UIImage imageNamed:self.moodArray[row]] forState:UIControlStateNormal];
        self.moodIndex = row;
    }
    
}

@end
