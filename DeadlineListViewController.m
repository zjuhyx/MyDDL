//
//  DeadlineListViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "DeadlineListViewController.h"
#import "DeadlineCell.h"
#import "DeadlineDetailController.h"

@interface DeadlineListViewController ()

@end

@implementation DeadlineListViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        //...
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Deadline列表";
    //_dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeadlineCell *cell=[[DeadlineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    
    Deadline* deadline=[_dataArray objectAtIndex:indexPath.row];
    
    NSDate *date = [NSDate date];//获取当前时间
    if(deadline.isCompleted==YES){
        if([[deadline.date earlierDate:date] isEqualToDate:date]){
            [cell setDDLStatus:2];//晚于现在的已完成
        }
        else{
            [cell setDDLStatus:4];
        }
    }
    else{
        if([[deadline.date earlierDate:date] isEqualToDate:date]){
            [cell setDDLStatus:1];
        }
        else{
            [cell setDDLStatus:3];
        }
    }
    
    cell.textLabel.text = deadline.name;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式
    cell.detailTextLabel.text = [dateFormat stringFromDate:deadline.date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DeadlineDetailController *deadlineDetailController=[DeadlineDetailController alloc];
//    deadlineDetailController.deadline=[data objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:deadlineDetailController animated:YES];
    [self.navigationController pushViewController:[[DeadlineDetailController alloc] init] animated:YES];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}



@end
