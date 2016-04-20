//
//  GroupDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupDetailTableViewController.h"
#import "AddGroupMemberController.h"

#import "IntroCell.h"

@implementation GroupDetailTableViewController

- (instancetype)initWithGroup:(Group *)group {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.group = group;
        
        self.navigationItem.title = group.name;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroupMember)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];//???
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[4] = {2, 1, 0, 1};
    int numberOfMembers = 2;    // 获取小组成员数量
    numberOfRows[2] = numberOfMembers;
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0){
        return 180;
    }
    else if(indexPath.section==2){
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
        IntroCell *intro_cell = [[IntroCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
        [intro_cell setCellLabel1:self.group.name label2:@"xx课程"];
        [intro_cell setCellImage:self.group.avatar imageName:nil];
        return intro_cell;
    }
    
    else{
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            cell.textLabel.text = @"二维码";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section==1){
            cell.textLabel.text = @"查看Deadlines";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        } else if(indexPath.section == 3) {
            cell.textLabel.text = @"退出小组";
            cell.textLabel.textColor=[UIColor redColor];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
        } else {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"胡译心";
            } else {
                cell.textLabel.text = @"柯瀚仰";
            }
            cell.imageView.image = [UIImage imageNamed:@"avatar_default"];
            CALayer *layer = cell.imageView.layer;
            layer.masksToBounds = YES;
            layer.cornerRadius = 25;
            cell.userInteractionEnabled = NO;
        }
        return cell;
    }
    
}

- (void)addGroupMember {
    [self.navigationController pushViewController:[[AddGroupMemberController alloc] init] animated:YES];
}

@end
