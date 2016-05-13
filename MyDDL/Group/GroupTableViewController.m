//
//  GroupTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupDetailTableViewController.h"
#import "EditGroupViewController.h"
#import "GroupModel.h"
#import "Model.h"

@interface GroupTableViewController () <UIActionSheetDelegate>

@end

@implementation GroupTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"小组";
        _isShare=NO;
    }
    return self;
}

-(void) viewDidLoad{
    if(_isShare==NO)
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
}

-(void)viewWillAppear:(BOOL)animated{
    _groups=[GroupModel getInstance].groups;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = _groups[indexPath.row].name;
    if(_isShare==NO){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //cell.imageView.image = [UIImage imageNamed:groupImageName[indexPath.row]];
    cell.imageView.image = [[Model getInstance] getImage:_groups[indexPath.row].image];

    CGSize size = CGSizeMake(58, 58);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [cell.imageView.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    //image=scaledImage;
    
    CALayer *layer = cell.imageView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 29;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_isShare==YES){
        _groupId=_groups[indexPath.row].groupId;
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"确定共享该deadline？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
    }
    else{
        GroupDetailTableViewController *detailViewController = [[GroupDetailTableViewController alloc] initWithGroup:_groups[indexPath.row]];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        if(_isShare){
            [[GroupModel getInstance] addGroupDeadlineWithGroupId:_groupId deadline:_deadline];
            
        }
        //- (void)addGroupDeadlineWithGroupId:(long)groupId deadlineId:(long)deadlineId;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addGroup {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"创建小组", @"扫描二维码加入小组",nil];
    actionSheet.tag=1;
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        EditGroupViewController *editGroupViewController=[EditGroupViewController alloc];
        editGroupViewController.formTitle=@"创建群";
        editGroupViewController.isCreate=YES;
        editGroupViewController=[editGroupViewController init];
        [self.navigationController pushViewController:editGroupViewController animated:YES];
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
        long groupId = [obj.stringValue intValue];
        [[GroupModel getInstance] addGroupUserWithGroupId:groupId user:[Model getInstance].userInfo];
        Group *group = [[GroupModel getInstance] getRemoteGroupById:groupId];
        [[GroupModel getInstance].groups addObject:group];
        [self.tableView reloadData];
    }
    
}


@end
