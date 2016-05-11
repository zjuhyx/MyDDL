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

@implementation GroupDetailTableViewController

- (instancetype)initWithGroup:(Group *)group {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _group = group;
        GroupModel* groupModel=[GroupModel getInstance];
        self.navigationItem.title = _group.name;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(toEdit)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];//???
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[5] = {2, 1, 1, 0, 1};
    // 获取小组成员数量
    numberOfRows[3] = (int)_group.members.count;
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0){
        return 180;
    }
    else if(indexPath.section==3){
        return 60;
    }
    else{
        return 50;
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
        [intro_cell setCellImage:_group.avatar imageName:nil];
        
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
            cell=[cell initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            cell.detailTextLabel.text=@"05/23/2016";
            cell.textLabel.text=@"这是一条最新的群动态！！";
            cell.imageView.image=[UIImage imageNamed:@"unread1"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section==2){
            cell.textLabel.text = @"查看Deadlines";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section == 4) {
            cell.textLabel.text = @"退出小组";
            cell.textLabel.textColor=[UIColor redColor];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
        } else {
            cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.text = _group.members[indexPath.row].userName;
            //cell.detailTextLabel.text=_group.members[indexPath.row].userName;
            
//            if (indexPath.row == 0) {
//                //cell.textLabel.text = @"胡译心";
//                cell.detailTextLabel.text=@"群主";
//            } else {
//                //cell.textLabel.text = @"柯瀚仰";
//                cell.detailTextLabel.text=@"成员";
//            }
//            cell.detailTextLabel.textColor=[UIColor grayColor];
            cell.imageView.image = [UIImage imageNamed:@"avatar_default"];
            CALayer *layer = cell.imageView.layer;
            layer.masksToBounds = YES;
            layer.cornerRadius = 25;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            //cell.userInteractionEnabled = NO;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==1){
        QRcodeViewController *QRViewController = [[QRcodeViewController alloc] init];
        [self presentViewController:QRViewController animated:YES completion:^{//备注2
            NSLog(@"showQR!");
        }];
    }
    else if(indexPath.section==1){
        [self.navigationController pushViewController:[[UpdatesTableViewController alloc] init] animated:YES];
    }
    else if (indexPath.section == 2) {
        DeadlineListViewController* deadlineListViewController=[DeadlineListViewController alloc];
        deadlineListViewController.dataArray=_group.deadlines;
        deadlineListViewController=[deadlineListViewController init];
        [self.navigationController pushViewController:deadlineListViewController animated:YES];
    }
    else if(indexPath.section==3){
        UserDetailViewController* userDetailViewController=[UserDetailViewController alloc];
        userDetailViewController.user=_group.members[indexPath.row];
        userDetailViewController=[userDetailViewController init];
        [self.navigationController pushViewController:userDetailViewController animated:YES];
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
    editGroupViewController.groupName=_group.name;
    editGroupViewController.groupImage=_group.avatar;
    editGroupViewController.groupNickname=[Model getInstance].username;
    editGroupViewController.groupLeader=@"组长xxx";
    editGroupViewController=[editGroupViewController init];
    [self.navigationController pushViewController:editGroupViewController animated:YES];
}

@end
