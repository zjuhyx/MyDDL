//
//  GroupDetailTableViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "GroupDetailTableViewController.h"
#import "DeadlineListViewController.h"
#import "IntroCell.h"
#import "UserDetailViewController.h"
#import "ImageDetailViewController.h"
#import "QRcodeViewController.h"
#import "UpdatesTableViewController.h"
#import "EditGroupViewController.h"
#import "Model.h"
#import "GroupModel.h"

@implementation GroupDetailTableViewController

- (instancetype)initWithGroup:(Group *)group {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _group = group;
        self.navigationItem.title = _group.name;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(toEdit)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];//???
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[5] = {2, 1, 1, 0, 1};
    // 获取小组成员数量
    numberOfRows[3] = (int)_group.members.count+1;
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0){
        return 180;
    }
    else if(indexPath.section==3 && indexPath.row>0){
        return 60;
    }
    else{
        return 43;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0){
        IntroCell *intro_cell = [[IntroCell alloc] init];
        [intro_cell setCellLabel1:_group.name label2:[NSString stringWithFormat:@"群号：%ld",_group.groupId]];
        
        [intro_cell setCellImage:[[Model getInstance] getImage:_group.image] imageName:nil];
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [intro_cell.intro_image_view addGestureRecognizer:singleRecognizer];
        [intro_cell.intro_image_view setUserInteractionEnabled:YES];//这句话一定要加！！！
        
        _avater_image=intro_cell.intro_image_view.image;
        
        return intro_cell;
    }
    
    else{
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            cell.textLabel.text = @"二维码";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section==1){
            NSArray<GroupMessage *> *messages=[[GroupModel getInstance] getGroupMessages:_group.groupId];
            if(messages.count>0){
                cell=[cell initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"MM/dd/yyyy";
                cell.detailTextLabel.text = [formatter stringFromDate:messages[0].date];
                cell.textLabel.text=messages[0].content;
                cell.imageView.image=[UIImage imageNamed:@"unread1"];
            }
            else{
                cell.textLabel.text=@"目前没有群消息";
                //cell.textLabel.textColor=[UIColor grayColor];
                cell.imageView.image=[UIImage imageNamed:@"unread2"];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section==2){
            cell.textLabel.text = @"查看Deadlines";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section == 4) {
            cell.textLabel.text = @"退出小组";
            cell.textLabel.textColor=[UIColor redColor];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
        } else {
            if(indexPath.row==0)
                cell.textLabel.text = @"群成员";
            else{
                cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
                cell.textLabel.text = _group.members[indexPath.row-1].userName;
                cell.imageView.image = [[Model getInstance] getImage:_group.members[indexPath.row-1].userImageId];
                
                CGSize size = CGSizeMake(50, 50);
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
                layer.cornerRadius = 25;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                //cell.userInteractionEnabled = NO;
            }
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==1){
        QRcodeViewController *QRViewController = [[QRcodeViewController alloc] init];
        QRViewController.groupId = [NSString stringWithFormat:@"%ld", _group.groupId];
        [self presentViewController:QRViewController animated:YES completion:^{//备注2
            NSLog(@"showQR!");
        }];
    }
    else if(indexPath.section==1){//共享
        UpdatesTableViewController* updatesTableViewController=[UpdatesTableViewController alloc];
        updatesTableViewController.groupId=_group.groupId;
        [self.navigationController pushViewController:[updatesTableViewController init] animated:YES];
    }
    else if (indexPath.section == 2) {
        DeadlineListViewController* deadlineListViewController=[DeadlineListViewController alloc];
        deadlineListViewController.groupId=_group.groupId;
        deadlineListViewController.dataArray=_group.deadlines;
        deadlineListViewController=[deadlineListViewController init];
        [self.navigationController pushViewController:deadlineListViewController animated:YES];
    }
    else if(indexPath.section==3 && indexPath.row>0){
        UserDetailViewController* userDetailViewController=[UserDetailViewController alloc];
        userDetailViewController.user=_group.members[indexPath.row-1];
        userDetailViewController=[userDetailViewController init];
        [self.navigationController pushViewController:userDetailViewController animated:YES];
    }
    else if(indexPath.section==4){
        [[GroupModel getInstance] deleteGroupUserByGroupId:_group.groupId userId:[Model getInstance].userInfo.userId];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pickImage{
    ImageDetailViewController *imageDetailViewController = [[ImageDetailViewController alloc] init];
    imageDetailViewController.image=_avater_image;
    [self presentViewController:imageDetailViewController animated:YES completion:^{//备注2
        NSLog(@"showImage!");
    }];
    
}

-(void)toEdit{
    EditGroupViewController *editGroupViewController=[EditGroupViewController alloc];
    editGroupViewController.formTitle=@"编辑群信息";
    editGroupViewController.isCreate=NO;
    editGroupViewController.group=_group;
    //editGroupViewController.groupName=_group.name;
    //editGroupViewController.groupImage=[[Model getInstance] getImage:_group.image];
    //editGroupViewController.groupNickname=[Model getInstance].username;
    //editGroupViewController.groupLeader=@"组长xxx";
    editGroupViewController=[editGroupViewController init];
    [self.navigationController pushViewController:editGroupViewController animated:YES];
}

@end
