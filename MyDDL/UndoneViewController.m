//
//  UndoneTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "UndoneViewController.h"
#import "CreateCourseDeadlineController.h"
#import "CreateProjectDeadlineController.h"
#import "SearchDeadlineController.h"
#import "DeadlineModel.h"
#import "CreateDeadlineController.h"

@interface UndoneViewController () <UIActionSheetDelegate>

@end

@implementation UndoneViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"未完成";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDeadline)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchDeadline)];
    }
    return self;
}

- (NSArray<Deadline *> *)deadlines {
    return [DeadlineModel getDeadlineModel].allUndoneDeadlines;
}

- (void)addDeadline {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"创建deadline", @"扫描二维码获取deadline",nil];
    actionSheet.tag=1;
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==1){//
        if(buttonIndex==0){
            [self.navigationController pushViewController:[[CreateDeadlineController alloc] initWithDeadlineController:self] animated:YES];
        }
        else{
            //扫描二维码
            // 1. 实例化拍摄设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            // 2. 设置输入设备
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            
            // 3. 设置元数据输出
            // 3.1 实例化拍摄元数据输出
            AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
            
            // 3.3 设置输出数据代理
            [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            
            // 4. 添加拍摄会话
            // 4.1 实例化拍摄会话
            AVCaptureSession *session = [[AVCaptureSession alloc] init];
            // 4.2 添加会话输入
            [session addInput:input];
            // 4.3 添加会话输出
            [session addOutput:output];
            // 4.4 设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
            [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            self.session = session;
            
            // 5. 视频预览图层
            // 5.1 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
            AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            preview.frame = self.view.bounds;
            // 5.2 将图层插入当前视图
            [self.view.layer insertSublayer:preview atIndex:100];
            self.previewLayer = preview;
            
            // 6. 启动会话
            [_session startRunning];
        }
    }
    if(actionSheet.tag==2){
        if (buttonIndex == 0) {
            [self LocalPhoto];
        }else if (buttonIndex == 1) {
            [self takePhoto];
        }
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    NSLog(@"%@", metadataObjects);
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0){
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
        NSLog(@"%@", obj.stringValue);
    }
    
}

-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil){
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else{
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    } 
    
}

//取消选择一张图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else{
        //NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)searchDeadline {
    [self.navigationController pushViewController:[[SearchDeadlineController alloc] init] animated:YES];
}

@end
