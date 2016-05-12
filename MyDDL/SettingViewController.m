//
//  SettingViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/19.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "SettingViewController.h"
#import "Model.h"

@interface SettingViewController() <XLFormDescriptorDelegate>

@end

@implementation SettingViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        form.assignFirstResponderOnShow = YES;
        form = [XLFormDescriptor formDescriptorWithTitle:@"编辑"];//???
        
        //section1
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        section.footerTitle = @"注：用户账号一经设定，无法修改。";
        // 账号
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"id" rowType:XLFormRowDescriptorTypeText];
        row.title=@"账号";
        row.value=[NSString stringWithFormat:@"%ld",[Model getInstance].userInfo.userId];
        
        row.value=[Model getInstance].username;
        row.disabled=@(YES);
        [section addFormRow:row];
        //昵称
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText];
        row.title=@"昵称";
        row.value=[Model getInstance].userInfo.userName;
        [section addFormRow:row];
        //密码
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypePassword];
        row.title=@"密码";
        row.value=@"123456";//密码在哪里？！
        [section addFormRow:row];
        
        
        //section1
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        // 账号
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"phone" rowType:XLFormRowDescriptorTypeText];
        row.title=@"电话";
        row.value=[Model getInstance].userInfo.userPhone;
        [section addFormRow:row];
        //邮箱
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeText];
        row.title=@"邮箱";
        row.value=[Model getInstance].userInfo.userEmail;
        [section addFormRow:row];
        
        //头像
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"image" rowType:XLFormRowDescriptorTypeImage title:@"头像"];
        UIImage* tmp_image=[[Model getInstance] getImage:[Model getInstance].userInfo.userImageId];
        _defualtImage=[UIImage imageNamed:@"pickImage_default"];
        if([Model getInstance].userInfo.userImageId==0)
            row.value = [UIImage imageNamed:@"pickImage_default"];//头像在哪呢？！
        else
            row.value = tmp_image;
        [section addFormRow:row];
        
        self.form=form;//前面加了self = [super init];就可以用这一句了！！
        self.form.disabled = YES;
    }
    return self;

}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(toEdit:)];
}

- (void) toEdit:(UIBarButtonItem *)button{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入登陆密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    alert.tag=1;
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (alertView.tag==1 && [buttonTitle isEqualToString:@"确定"]){
        UITextField *tf=[alertView textFieldAtIndex:0];//获得输入框
        NSString *text=tf.text;//获得值
        //NSLog(text);
        if([[Model getInstance] loginWithUsername:[Model getInstance].username password:text]==YES){//验证密码
            [self.form formRowWithTag:@"password"].value=text;
            self.form.disabled = !self.form.disabled;
            [self.tableView endEditing:YES];
            [self.tableView reloadData];
            //开始编辑
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveEdit)];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void) saveEdit{
    UserInfo* userInfo=[[UserInfo alloc] init];
    userInfo.userId=[Model getInstance].userInfo.userId;
    XLFormRowDescriptor* row=[self.form formRowWithTag:@"name"];
    userInfo.userName=row.value;
    row=[self.form formRowWithTag:@"password"];
    [[Model getInstance] changeUserPassword:row.value];
    row=[self.form formRowWithTag:@"phone"];
    userInfo.userPhone=row.value;
    row=[self.form formRowWithTag:@"email"];
    userInfo.userEmail=row.value;
    row=[self.form formRowWithTag:@"image"];
    //if([row.value isEqual:_defualtImage])
        userInfo.userImageId=[[Model getInstance] addImage:row.value];
    [[Model getInstance] changeUserInfo:userInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
