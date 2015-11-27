//
//  LoginViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "LoginViewController.h"
#import "Information.h"

#define ITEM_WIDTH 200.0
#define ITEM_HEIGHT 35.0

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return self;
    }
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat baseX = screenSize.width / 2 - ITEM_WIDTH / 2;
    CGFloat baseY = screenSize.height / 2 - 3 * ITEM_HEIGHT;
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(baseX, baseY, ITEM_WIDTH, ITEM_HEIGHT)];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(baseX, baseY + 1.5 * ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT)];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameTextField.placeholder = @"用户名";
    self.passwordTextField.placeholder = @"密码";
    self.usernameTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.secureTextEntry = YES;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginButton.frame = CGRectMake(baseX, baseY + 4 * ITEM_HEIGHT, ITEM_WIDTH, ITEM_HEIGHT);
    self.loginButton.tintColor = [UIColor whiteColor];
    self.loginButton.backgroundColor = [UIColor colorWithRed:10./255 green:210./255 blue:120./255 alpha:1.];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
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

- (void)login {
    [Information getInformation].username = self.usernameTextField.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
