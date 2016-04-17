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
    return indexPath.section == 0 ? 180 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *username = [Information getInformation].username;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (indexPath.section == 0) {
        CGFloat radius = 40.0;
        //cell.imageView.image = [UIImage imageNamed:@"avatar_default"];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0-radius, 20, 80, 80)];
        //CALayer *layer = cell.imageView.layer;
        CALayer *layer = imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = radius;
        imageView.image=[UIImage imageNamed:@"avatar_default"];
        [cell addSubview:imageView];
        [imageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)]];
        //不知道为什么没有用？？！！
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2, 200, 50)];
        label.text=username;
        label.textAlignment = UITextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:19];
        [cell addSubview:label];
        //cell.userInteractionEnabled = NO;
        
        UILabel *subLabel=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2+25, 200, 50)];
        subLabel.text=@"账号：523074";
        subLabel.textAlignment = UITextAlignmentCenter;
        subLabel.font=[UIFont systemFontOfSize:13];
        subLabel.textColor=[UIColor grayColor];
        [cell addSubview:subLabel];

        
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
                                   @[[SettingTableViewController class]]];
    if (indexPath.section != 0) {
        [self.navigationController pushViewController:[[controllerClasses[indexPath.section][indexPath.row] alloc] init] animated:YES];
    }
}

-(void)pickImage:(UIImage *) image{
    NSLog(@"pickImage!!");
}

@end
