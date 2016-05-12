//
//  CourseAndProjectDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseAndProjectDetailTableViewController.h"
#import "CourseProjectModel.h"
#import "DeadlineListViewController.h"
#import "UserDetailViewController.h"


@implementation CourseAndProjectDetailTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        self.navigationItem.title = self.courseAndProject.name;
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editItem)];
        _blueColor = [UIColor colorWithRed:0 green:91./255 blue:255./255 alpha:1.];
    }
    return self;
}

-(void)viewDidLoad{
    self.navigationItem.title = self.courseAndProject.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editItem)];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[2] = {3, 1};
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0)
        return 70;
    if(indexPath.section==0 && indexPath.row==2)
        return 200;
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if(indexPath.row==0){
            cell.textLabel.text = self.courseAndProject.name;
            cell.textLabel.font = [UIFont systemFontOfSize:25];
        }
        else if(indexPath.row==1){
            cell.textLabel.text=@"查看deadlines";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell.textLabel.text = self.courseAndProject.detail;
        }
        //cell.userInteractionEnabled = NO;
    }
//    else if (indexPath.section == 1) {
//        cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
//        cell.textLabel.font = [UIFont systemFontOfSize:13];
//        cell.textLabel.textColor=_blueColor;
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
//        
//        if(indexPath.row==0){
//            cell.textLabel.text=@"联系人";
//            cell.detailTextLabel.text=self.courseAndProject.
//        }
//        else if(indexPath.row==1){
//            cell.textLabel.text=@"联系电话";
//            cell.detailTextLabel.text=@"18868101111";
//        }
//        else{
//            cell.textLabel.text=@"邮箱";
//            cell.detailTextLabel.text=@"liu@hotmail.com";
//        }
//        
//    } else if(indexPath.section==2) {
//        cell.textLabel.text=@"新建小组";//or @"查看小组"
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }
    else {
        cell.textLabel.text = self.deleteItem;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

- (void)editItem {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row==1) {
        DeadlineListViewController* deadlineListViewController=[DeadlineListViewController alloc];
        deadlineListViewController.dataArray=[[CourseProjectModel getInstance] getDeadlinesByCourseProjectId:_courseAndProject.courseProjectId];
        [self.navigationController pushViewController:[deadlineListViewController init] animated:YES];
    }
    if(indexPath.section==1){
        [[CourseProjectModel getInstance] deleteCourseProject:_courseAndProject];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
