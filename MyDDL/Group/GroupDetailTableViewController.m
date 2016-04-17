//
//  GroupDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupDetailTableViewController.h"
#import "AddGroupMemberController.h"

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[3] = {1, 0, 1};
    int numberOfMembers = 2;    // 获取小组成员数量
    numberOfRows[1] = numberOfMembers;
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    } else if (indexPath.section == 1) {
        return 44;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.group.name;
        cell.imageView.image = self.group.avatar;
        CALayer *layer = cell.imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 25;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"退出小组";
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"胡译心";
        } else {
            cell.textLabel.text = @"柯瀚仰";
        }
        cell.imageView.image = [UIImage imageNamed:@"avatar_default"];
        CALayer *layer = cell.imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 22;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)addGroupMember {
    [self.navigationController pushViewController:[[AddGroupMemberController alloc] init] animated:YES];
}

@end
