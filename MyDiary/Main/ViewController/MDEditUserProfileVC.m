//
//  MDEditUserProfileVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/9.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDEditUserProfileVC.h"
#import "MDTheme.h"
#import "UIImage+MyDiary.h"
#import "MDAsync.h"

@interface MDEditUserProfileVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;//头像按钮
@property (weak, nonatomic) IBOutlet UIButton *backBtn;//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//完成按钮
@property (strong, nonatomic) NSMutableArray * data;//数据源
@property (strong, nonatomic) UIAlertController * alertController;//选择器 iOS8 新增
@property (strong, nonatomic) UIImagePickerController * picker;// 相册&拍照
@property (assign, nonatomic) NSInteger selectedSegmentIndex;
@property (strong, nonatomic) NSString * userName;//昵称

@end

@implementation MDEditUserProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    
    //返回按钮
    [self.backBtn setImage:[UIImage imageNamed:@"pk_back_btn"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    //完成按钮
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    //头像按钮
    [self.headBtn addTarget:self action:@selector(headBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
//主题切换器
- (void)themeSeg:(UISegmentedControl *)seg {
    
    self.selectedSegmentIndex = seg.selectedSegmentIndex;
    
}

//头像按钮
- (void)headBtn:(UIButton *)btn {
    
    if (self.alertController == nil) {
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"拍照&相册" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
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
        
        [self.alertController addAction:photograph];
        [self.alertController addAction:photoAlbum];
        [self.alertController addAction:cancel];

    }
    [self presentViewController:self.alertController animated:YES completion:nil];
    
}

//返回按钮
- (void)backBtn:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

//完成按钮
- (void)okBtn:(UIButton *)btn {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInteger:self.selectedSegmentIndex] forKey:@"Theme"];
    [userDefaults synchronize];
    
    //主题变更通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kMDThemeChangeNotification" object:self userInfo:nil];
    
    //修改导航栏颜色
    [MDTheme modifyNavigationBarColor];
    
    //异步存储个人信息
    [MDAsync async_saveUserInfo:self.headBtn.imageView.image userName:self.userName];
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    //标题
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:2000];
    titleLabel.text = self.data[indexPath.row];
    
    //输入框
    UITextField * inputTextField = (UITextField *)[cell viewWithTag:3000];
    inputTextField.hidden = NO;
    [inputTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row != 0) {
        inputTextField.hidden = YES;
    }
    
    //主题切换器
    UISegmentedControl * themeSeg = (UISegmentedControl *)[cell viewWithTag:4000];
    themeSeg.hidden = YES;
    themeSeg.tintColor = [MDTheme themeColor];
    [themeSeg addTarget:self action:@selector(themeSeg:) forControlEvents:UIControlEventValueChanged];
    
    if (indexPath.row == 1) {
        themeSeg.hidden = NO;
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"Theme"]) {
            NSNumber * segmentIndex = [userDefaults objectForKey:@"Theme"];
            themeSeg.selectedSegmentIndex = segmentIndex.integerValue;
        }
        else{
            themeSeg.selectedSegmentIndex = 0;
        }
    }
    
    
    //点击效果 影响输入框点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 相机相关 -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
    {
        //获取照片实例
        NSData * imgData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.7);
        UIImage * image = [UIImage imageWithData:imgData];
        [self.headBtn setImage:image forState:UIControlStateNormal];
        
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

#pragma mark UITextView 相关
- (void)textChange:(UITextField *)textField {
    
    self.userName = textField.text;
}

#pragma mark 懒加载
//数据源
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [[NSMutableArray alloc] initWithObjects:@"昵称",@"主题", nil];
    }
    return _data;
}

- (UIImagePickerController *)picker {
    
    if (_picker == nil) {
        //初始化 相机
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
    }
    return _picker;
}
@end
