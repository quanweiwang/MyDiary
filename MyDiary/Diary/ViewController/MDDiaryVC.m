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

@interface MDDiaryVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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

@property (strong, nonatomic) UIImagePickerController * picker;// 相册&拍照

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

@end
