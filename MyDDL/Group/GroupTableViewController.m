//
//  GroupTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupDetailTableViewController.h"
#import "BeforeCreateGroupViewController.h"
#import "GroupModel.h"

@interface GroupTableViewController () <UIActionSheetDelegate>

@end

@implementation GroupTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"小组";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
    }
    _groups=[GroupModel getInstance].groups;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups.count;
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
    
    //NSArray<NSString *> *groupName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"国创"];
    //NSArray<NSString *> *groupImageName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"group_default"];
    
    cell.textLabel.text = _groups[indexPath.row].name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.imageView.image = [UIImage imageNamed:groupImageName[indexPath.row]];
    cell.imageView.image = _groups[indexPath.row].avatar;
    CALayer *layer = cell.imageView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 25;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSArray<NSString *> *groupName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"国创"];
    //NSArray<NSString *> *groupImageName = @[@"毛概讨论组", @"软件工程小组", @"省创", @"group_default"];
    
    //Group *group = [[Group alloc] initWithName:groupName[indexPath.row] deadlines:nil];
    //group.avatar = [UIImage imageNamed:groupImageName[indexPath.row]];
    GroupDetailTableViewController *detailViewController = [[GroupDetailTableViewController alloc] initWithGroup:_groups[indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)addGroup {
    [self.navigationController pushViewController:[[BeforeCreateGroupViewController alloc] init] animated:YES];
}


@end
