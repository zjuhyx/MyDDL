//
//  DoneTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DoneViewController.h"
#import "DeadlineModel.h"

#import "SearchDeadlineController.h"
#import "DeleteDeadlineViewController.h"

@implementation DoneViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"已完成";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchDeadline)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteDoneDeadline)];
    }
    [DoneViewController setAndGetInstance:self];
    return self;
}

+ (DoneViewController *)setAndGetInstance:(DoneViewController *)doneViewController {
    static DoneViewController *instance = nil;
    if (doneViewController != nil) {
        instance = doneViewController;
    }
    return instance;
}

- (NSArray<Deadline *> *)deadlines {
    return [DeadlineModel getDeadlineModel].allDoneDeadlines;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self LocalPhoto];
    }else if (buttonIndex == 1) {
        [self takePhoto];
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

- (void)deleteDoneDeadline {
    DeleteDeadlineViewController* deleteViewController=[[DeleteDeadlineViewController alloc] init];
    deleteViewController.deadlineController=self;
    [self.navigationController pushViewController:deleteViewController animated:YES];
}

@end
