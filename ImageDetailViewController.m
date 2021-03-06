//
//  ImageDetailViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "ImageDetailViewController.h"

#import "DeadlineCell.h"

@interface ImageDetailViewController ()

@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat height=_image.size.height*(screenWidth/_image.size.width);
    UIImageView *image_view=[[UIImageView alloc] initWithFrame:CGRectMake(0,(screenHeight-height)/2,screenWidth,height)];
    image_view.image=_image;
    [self.view addSubview:image_view];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) toCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
