//
//  GroupTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupDetailTableViewController.h"
#import "CreateGroupController.h"
#import "JoinGroupController.h"

@interface GroupTableViewController () <UIActionSheetDelegate>

@end

@implementation GroupTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"小组";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
    
    NSArray<NSString *> *groupName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"国创"];
    NSArray<NSString *> *groupImageName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"group_default"];
    
    cell.textLabel.text = groupName[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:groupImageName[indexPath.row]];
    CALayer *layer = cell.imageView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 25;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray<NSString *> *groupName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"国创"];
    NSArray<NSString *> *groupImageName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"group_default"];
    
    Group *group = [[Group alloc] initWithName:groupName[indexPath.row] deadlines:nil];
    group.avatar = [UIImage imageNamed:groupImageName[indexPath.row]];
    GroupDetailTableViewController *detailViewController = [[GroupDetailTableViewController alloc] initWithGroup:group];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)addGroup {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"创建小组", @"加入小组", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController pushViewController:[[CreateGroupController alloc] init] animated:YES];
    } else if (buttonIndex == 1) {
        [self.navigationController pushViewController:[[JoinGroupController alloc] init] animated:YES];
    }
}

@end
