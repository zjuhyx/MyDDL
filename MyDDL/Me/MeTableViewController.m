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

@implementation MeTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRowsInSection[3] = {1, 2, 1};
    return numberOfRowsInSection[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    NSArray *texts = @[@[@""], @[@"课程", @"项目"], @[@"设置"]];
    tableViewCell.textLabel.text = texts[indexPath.section][indexPath.row];
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
