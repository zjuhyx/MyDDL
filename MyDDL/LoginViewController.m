//
//  LoginViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "LoginViewController.h"
#import "Information.h"

#import "MainTabBarController.h"
#import "RegisterViewController.h"

#define ITEM_WIDTH 300.0
#define ITEM_HEIGHT 50.0

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UIImage *bg_image=[UIImage imageNamed:@"bg2"];
        CGFloat height=bg_image.size.height*(screenWidth/bg_image.size.width);
        UIImageView *image_view=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenWidth,height)];
        image_view.image=bg_image;
        [self.view addSubview:image_view];

        UIImage *ddl_image=[UIImage imageNamed:@"ddl"];
        CGFloat width2=screenWidth/3;
        CGFloat height2=ddl_image.size.height*(width2/ddl_image.size.width);
        UIImageView *image_view2=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/3,height/6,width2,height2)];
        image_view2.image=ddl_image;
        [self.view addSubview:image_view2];
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGFloat baseX = screenSize.width / 2 - ITEM_WIDTH / 2;
        CGFloat baseY = height/2+20;
        self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(baseX+60, baseY, ITEM_WIDTH-60, ITEM_HEIGHT)];
        self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(baseX+60, baseY + ITEM_HEIGHT + 20, ITEM_WIDTH-60, ITEM_HEIGHT)];
        self.usernameTextField.borderStyle = UITextBorderStyleNone;
        self.passwordTextField.borderStyle = UITextBorderStyleNone;
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(baseX, baseY+ITEM_HEIGHT, ITEM_WIDTH, 1.5)];
        view1.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view1];
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(baseX, baseY + 2 * ITEM_HEIGHT+20, ITEM_WIDTH, 1.5)];
        view2.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view2];
        
        UIImage *user_image=[UIImage imageNamed:@"user_name"];
        UIImageView *image_view3=[[UIImageView alloc] initWithFrame:CGRectMake(baseX+10, baseY+10,30,30)];
        image_view3.image=user_image;
        [self.view addSubview:image_view3];

        UIImage *pwd_image=[UIImage imageNamed:@"pwd"];
        UIImageView *image_view4=[[UIImageView alloc] initWithFrame:CGRectMake(baseX+10, baseY + ITEM_HEIGHT + 20+10,30,30)];
        image_view4.image=pwd_image;
        [self.view addSubview:image_view4];
        
        self.usernameTextField.placeholder = @"用户名";
        self.passwordTextField.placeholder = @"密码";
        [_usernameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_usernameTextField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
        [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
        _usernameTextField.textColor=[UIColor whiteColor];
        _usernameTextField.font=[UIFont systemFontOfSize:20];
        _passwordTextField.textColor=[UIColor whiteColor];
        _passwordTextField.font=[UIFont systemFontOfSize:20];
        self.usernameTextField.returnKeyType = UIReturnKeyDone;
        self.passwordTextField.returnKeyType = UIReturnKeyDone;
        self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.passwordTextField.secureTextEntry = YES;
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
        _log_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _log_btn.frame = CGRectMake(baseX, baseY + 3 * ITEM_HEIGHT+20, ITEM_WIDTH, ITEM_HEIGHT);
        _log_btn.tintColor = [UIColor whiteColor];
        _log_btn.backgroundColor = [UIColor colorWithRed:66./255 green:191./255 blue:255./255 alpha:1.];
        _log_btn.titleLabel.font= [UIFont boldSystemFontOfSize:22.0];
        [_log_btn setTitle:@"登   录" forState:UIControlStateNormal];
        [_log_btn.layer setCornerRadius:4];
        [_log_btn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
        
        _reg_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _reg_btn.frame = CGRectMake(baseX, baseY + 4 * ITEM_HEIGHT+2*20, ITEM_WIDTH, ITEM_HEIGHT);
        _reg_btn.tintColor = [UIColor grayColor];
        _reg_btn.titleLabel.font= [UIFont systemFontOfSize:22.0];
        [_reg_btn setTitle:@"注   册" forState:UIControlStateNormal];
        [_reg_btn.layer setCornerRadius:4];
        [_reg_btn.layer setBorderWidth:.5];
        [_reg_btn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
        
        _forget_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _forget_btn.frame = CGRectMake(baseX, baseY + 5 * ITEM_HEIGHT+2*20+10, ITEM_WIDTH, ITEM_HEIGHT/3);
        _forget_btn.tintColor = [UIColor grayColor];
        _forget_btn.titleLabel.font= [UIFont systemFontOfSize:13.0];
        [_forget_btn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forget_btn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.usernameTextField];
        [self.view addSubview:self.passwordTextField];
        [self.view addSubview:_log_btn];
        [self.view addSubview:_reg_btn];
        [self.view addSubview:_forget_btn];

    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)toLogin {
    [Information getInformation].username = self.usernameTextField.text;
    
    MainTabBarController *mainViewController = [[MainTabBarController alloc] init];
    mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//设置动画效果
    [self presentViewController:mainViewController animated:YES completion:^{//备注2
        NSLog(@"main view!");
    }];

}

-(void)toRegister{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
    
    RegisterViewController *regViewController = [[RegisterViewController alloc] init];
    regViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//设置动画效果
    [self presentViewController:regViewController animated:YES completion:^{//备注2
        NSLog(@"reg view!");
    }];
}

@end
