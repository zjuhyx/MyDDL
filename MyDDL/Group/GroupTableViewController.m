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
    }
}


@end
