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
#import "Information.h"

#import "IntroCell.h"

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
    return indexPath.section == 0 ? 180 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *username = [Information getInformation].username;
    
    if (indexPath.section == 0) {
        IntroCell *intro_cell = [[IntroCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:@"UITableViewCell"];
        [intro_cell setCellLabel1:username label2:@"账号：624509"];
        [intro_cell setCellImage:nil imageName:@"avatar_default"];
        return intro_cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"课程";
        cell.imageView.image = [UIImage imageNamed:@"course"];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"项目";
        cell.imageView.image = [UIImage imageNamed:@"project"];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"设置";
        cell.imageView.image = [UIImage imageNamed:@"setting"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *controllerClasses = @[@[],
                                   @[[CourseTableViewController class],
                                     [ProjectTableViewController class]],
                                   @[[SettingViewController class]]];
    if (indexPath.section != 0) {
        [self.navigationController pushViewController:[[controllerClasses[indexPath.section][indexPath.row] alloc] init] animated:YES];
    }
}


@end
