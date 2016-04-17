//
//  CourseAndProjectDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseAndProjectDetailTableViewController.h"

@implementation CourseAndProjectDetailTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = self.itemName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem)];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;   // 第一个section显示课程图标和课程名称，第二个section显示课程的备注
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height[3] = {60, 120, 44};
    return height[indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.itemName;
        cell.imageView.image = [UIImage imageNamed:self.itemImageName];
        CALayer *layer = cell.imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 25.0;
        cell.userInteractionEnabled = NO;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.itemDetail;
        cell.userInteractionEnabled = NO;
    } else {
        cell.textLabel.text = self.deleteItem;
    }
    return cell;
}

- (void)editItem {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

@end
