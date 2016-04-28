//
//  QRcodeViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "QRcodeViewController.h"

@interface QRcodeViewController ()

@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title=@"二维码";
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(toCancel)];
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
    self.view.backgroundColor=[UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) toCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
