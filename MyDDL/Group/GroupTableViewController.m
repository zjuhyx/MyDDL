//
//  GroupTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupDetailTableViewController.h"
#import "EditGroupViewController.h"
#import "GroupModel.h"

@interface GroupTableViewController () <UIActionSheetDelegate>

@end

@implementation GroupTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"小组";
        _isShare=NO;
    }
    _groups=[GroupModel getInstance].groups;
    return self;
}

-(void) viewDidLoad{
    if(_isShare==NO)
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
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
    if(_isShare){
        cell.userInteractionEnabled=NO;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //cell.imageView.image = [UIImage imageNamed:groupImageName[indexPath.row]];
    cell.imageView.image = _groups[indexPath.row].avatar;
    CALayer *layer = cell.imageView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 25;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_isShare==YES){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"确定共享该deadline？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
    }
    else{
        GroupDetailTableViewController *detailViewController = [[GroupDetailTableViewController alloc] initWithGroup:_groups[indexPath.row]];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        //。。。
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addGroup {
    EditGroupViewController *editGroupViewController=[EditGroupViewController alloc];
    editGroupViewController.formTitle=@"创建群";
    editGroupViewController.isCreate=YES;
    editGroupViewController=[editGroupViewController init];
    [self.navigationController pushViewController:editGroupViewController animated:YES];
}


@end
