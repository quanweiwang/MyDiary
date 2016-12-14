//
//  MDContactsVC.m
//  MyDiary
//
//  Created by 王权伟 on 2016/12/11.
//  Copyright © 2016年 wangquanwei. All rights reserved.
//

#import "MDContactsVC.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "MDContactsMdl.h"
#import "MDTheme.h"

@interface MDContactsVC ()<CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;//背景图片

@property (strong, nonatomic) NSMutableArray * data;

@end

@implementation MDContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_add_white_36dp"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.table.backgroundColor = [UIColor clearColor];
    
    //主题背景
    self.backgroundImg.image = [MDTheme themeContactsBackgroundImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件
- (void)rightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"新建联系人" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * addAction = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction * contactsAction = [UIAlertAction actionWithTitle:@"从通讯录选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_0) {
            
            CNContactPickerViewController * picker = [[CNContactPickerViewController alloc] init];
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        else{
            
        }
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:addAction];
    [alertController addAction:contactsAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    return 95;
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
    
    UIImageView * headImg = (UIImageView *)[cell viewWithTag:1000];
    headImg.tintColor = [UIColor grayColor];
    headImg.image = [[UIImage imageNamed:@"ic_contacts_image_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    MDContactsMdl * model = self.data[indexPath.row];
    UILabel * nameLabel = (UILabel *)[cell viewWithTag:2000];
    nameLabel.text = model.name;
    
    UILabel * phoneLabel = (UILabel *)[cell viewWithTag:3000];
    phoneLabel.text = model.phone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [NSArray arrayWithObjects:UITableViewIndexSearch,@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
}

#pragma mark CNContactPickerViewController相关
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    for (CNLabeledValue * labeledValue in contact.phoneNumbers) {
        
        CNPhoneNumber * phoneNumber = labeledValue.value;
        
        MDContactsMdl * model = [[MDContactsMdl alloc] init];
        model.name = contact.givenName;
        model.phone = phoneNumber.stringValue;
        
        [self.data addObject:model];
    }
    
    [self.table reloadData];
}

#pragma mark 懒加载
- (NSMutableArray *)data {
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
