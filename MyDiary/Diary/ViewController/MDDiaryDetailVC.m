//
//  MDDiaryDetailVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/20.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDDiaryDetailVC.h"
#import "QWTextView.h"
#import "MDTheme.h"
#import <CoreLocation/CoreLocation.h>

@interface MDDiaryDetailVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>

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
@property (weak, nonatomic) IBOutlet UIView *headView;//顶部视图
@property (weak, nonatomic) IBOutlet UIView *diaryLineView;//日记分割线
@property (weak, nonatomic) IBOutlet UIButton *editBtn;//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;//删除按钮
@property (weak, nonatomic) IBOutlet UIView *backgroundView;//背景视图
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;//关闭按钮

@property (strong, nonatomic) UIImagePickerController * picker;//相册&拍照
@property (nonatomic, strong) CLLocationManager* locationManager;//定位

@end

@implementation MDDiaryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.backgroundView.alpha = 0.3f;
    
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
    self.locationBtn.enabled = NO;
    [self.locationBtn addTarget:self action:@selector(locationBtn:) forControlEvents:UIControlEventTouchUpInside];
    //相机按钮
    self.cameraBtn.enabled = NO;
    [self.cameraBtn addTarget:self action:@selector(cameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    //删除按钮
    [self.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    //编辑按钮
    [self.editBtn addTarget:self action:@selector(editBtn:) forControlEvents:UIControlEventTouchUpInside];
    //关闭按钮
    [self.closeBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //默认状态
    self.diaryContentTextView.editable = NO;
    self.diaryTitleTextField.enabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//天气按钮
- (void) weatherBtn:(UIButton *)btn {
    
}
//心情按钮
- (void) moodBtn:(UIButton *)btn {
    
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
//删除按钮
- (void) deleteBtn:(UIButton *)btn {
    
        
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除日记内容吗" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * exitAction = [UIAlertAction actionWithTitle:@"狠心删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
                
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:exitAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//编辑按钮
- (void) editBtn:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.selected == true) {
        
        self.cameraBtn.enabled = YES;
        self.locationBtn.enabled = YES;
        self.diaryTitleTextField.enabled = YES;
        self.diaryContentTextView.editable = YES;
        [self.diaryContentTextView becomeFirstResponder];
    }
    else {
        
        self.cameraBtn.enabled = NO;
        self.locationBtn.enabled = NO;
        self.diaryTitleTextField.enabled = NO;
        self.diaryContentTextView.editable = NO;
        [self.view endEditing:YES];
    }
}
//关闭按钮
- (void) closeBtn:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
        
        self.locationLabel.text = [NSString stringWithFormat:@"%@ %@ %@",place.country, place.locality,place.subLocality];
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

@end
