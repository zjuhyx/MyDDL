//
//  MeViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "MeTableViewController.h"
#import "SettingTableViewController.h"
#import "CourseTableViewController.h"
#import "ProjectTableViewController.h"
#import "Information.h"

@implementation MeTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"我";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRowsInSection[3] = {1, 2, 1};
    return numberOfRowsInSection[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 70 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if (indexPath.section != 0) {
        tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *username = [Information getInformation].username;
    NSArray *texts = @[@[username], @[@"课程", @"项目"], @[@"设置"]];
    tableViewCell.textLabel.text = texts[indexPath.section][indexPath.row];
    tableViewCell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.section == 0) {
        CGFloat radius = 25.0;
        tableViewCell.imageView.image = [UIImage imageNamed:@"avatar_default"];
        CALayer *layer = tableViewCell.imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = radius;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        tableViewCell.imageView.image = [UIImage imageNamed:@"course"];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        tableViewCell.imageView.image = [UIImage imageNamed:@"project"];
    } else if (indexPath.section == 2) {
        tableViewCell.imageView.image = [UIImage imageNamed:@"setting"];
    }
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *controllerClasses = @[@[],
                                   @[[CourseTableViewController class],
                                     [ProjectTableViewController class]],
                                   @[[SettingTableViewController class]]];
    if (indexPath.section != 0) {
        [self.navigationController pushViewController:[[controllerClasses[indexPath.section] [indexPath.row] alloc] init] animated:YES];
    }
}

@end
