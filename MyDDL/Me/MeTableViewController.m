//
//  MeViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "MeTableViewController.h"
#import "SettingViewController.h"
#import "CourseTableViewController.h"
#import "ProjectTableViewController.h"
#import "IntroCell.h"
#import "ImageDetailViewController.h"
#import "NoticeTableViewController.h"
#import "Model.h"

@implementation MeTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"我";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(toLogOut)];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRowsInSection[4] = {1, 1, 2, 1};
    return numberOfRowsInSection[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 180 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *username = [Model getInstance].userInfo.userName;//昵称
    //NSString *userid = [NSString stringWithFormat:@"账号：%ld",[Model getInstance].userInfo.userId];
    
    if (indexPath.section == 0) {
        IntroCell *intro_cell = [[IntroCell alloc] init];
        [intro_cell setCellLabel1:username label2:@"该用户还没有填写自我介绍"];
        if([Model getInstance].userInfo.userImageId==0)
            [intro_cell setCellImage:nil imageName:@"avatar_default"];
        else
            [intro_cell setCellImage:[[Model getInstance] getImage:[Model getInstance].userInfo.userImageId] imageName:nil];
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [intro_cell.intro_image_view addGestureRecognizer:singleRecognizer];
        [intro_cell.intro_image_view setUserInteractionEnabled:YES];//这句话一定要加！！！
        
        _avater_image=intro_cell.intro_image_view.image;
        return intro_cell;
    } else if(indexPath.section==1){
        cell.textLabel.text=@"消息";
        cell.imageView.image=[UIImage imageNamed:@"notice"];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"课程";
        cell.imageView.image = [UIImage imageNamed:@"course"];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        cell.textLabel.text = @"项目";
        cell.imageView.image = [UIImage imageNamed:@"project"];
    } else if (indexPath.section == 3) {
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"setting"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *controllerClasses = @[@[],
                                   @[[NoticeTableViewController class]],
                                   @[[CourseTableViewController class],
                                     [ProjectTableViewController class]],
                                   @[[SettingViewController class]]];
    if (indexPath.section != 0) {
        [self.navigationController pushViewController:[[controllerClasses[indexPath.section][indexPath.row] alloc] init] animated:YES];
    }
}

- (void)pickImage{
    ImageDetailViewController *imageDetailViewController = [[ImageDetailViewController alloc] init];
    imageDetailViewController.image=_avater_image;
    [self presentViewController:imageDetailViewController animated:YES completion:^{//备注2
        NSLog(@"showImage!");
    }];
    
}

- (void) toLogOut{
    [[Model getInstance] clearData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
