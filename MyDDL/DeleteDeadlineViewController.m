//
//  DeleteDeadlineViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/16.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "DeleteDeadlineViewController.h"

@implementation DeleteDeadlineViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDeadline)];
        self.navigationItem.title=@"批量删除";

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"注意：Deadline记录一旦删除，无法恢复。";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"删除3天前的所有Deadline";
                break;
            case 1:
                cell.textLabel.text=@"删除一周前的所有Deadline";
                break;
            case 2:
                cell.textLabel.text=@"删除一个月前的所有Deadline";
                break;
            case 3:
                cell.textLabel.text=@"删除一年前的所有Deadline";
                break;
            case 4:
                cell.textLabel.text=@"删除所有Deadline";
                break;
                
            default:
                break;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *mesg=@"确定";
    mesg=[mesg stringByAppendingString:cell.textLabel.text];
    mesg=[mesg stringByAppendingString:@"？"];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:mesg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消点击cell之后显示的灰色
}


@end
