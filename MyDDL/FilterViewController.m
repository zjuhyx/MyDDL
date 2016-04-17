//
//  FilterViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/13.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "FilterViewController.h"
#import "Configuration.h"

@implementation FilterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toCancel)];
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(toFilter)];
    //设置导航栏内容
    //[navigationItem setTitle:@"雨松MOMO程序世界"];
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    [navigationItem setRightBarButtonItem:rightButton];
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
}

-(void)toCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)toFilter{
    
}

@end
