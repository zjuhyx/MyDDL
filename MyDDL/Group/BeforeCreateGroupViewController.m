//
//  CreateGroupController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/29/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "BeforeCreateGroupViewController.h"
#import "EditGroupViewController.h"

@implementation BeforeCreateGroupViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"选择课程或项目创建小组";
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2; // 应该返回deadline的数量
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditGroupViewController *editGroupViewController=[EditGroupViewController alloc];
    editGroupViewController.formTitle=@"创建群";
    editGroupViewController.isCreate=YES;
    editGroupViewController=[editGroupViewController init];
    [self.navigationController pushViewController:editGroupViewController animated:YES];}

@end
