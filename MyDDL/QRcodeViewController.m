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
    
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.width/2.0)];
    
    [self.view addSubview:_imgView];
    
    [self erweima];
}

-(void)erweima
{
    
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    //将字符串转换成NSData
    NSData *data=[@"www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    _imgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:[UIScreen mainScreen].bounds.size.width];
    NSLog(@"%f", [UIScreen mainScreen].bounds.size.width);
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//    _imgView.layer.shadowRadius=1;//设置阴影的半径
//    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//    _imgView.layer.shadowOpacity=0.3;
}


//改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    NSLog(@"%f", scale);
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    NSLog(@"%f, %f", (float)width, (float)height);
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) toCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
