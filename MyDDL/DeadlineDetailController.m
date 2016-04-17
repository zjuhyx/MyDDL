//
//  DeadlineDetailController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineDetailController.h"
#import "UndoneViewController.h"
#import "EditDeadlineController.h"
#import "DeadlineModel.h"
#import "DoneViewController.h"

@interface DeadlineDetailController ()

@property (nonatomic, weak) DeadlineController *deadlineController;

@end



@implementation DeadlineDetailController


- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDeadline)];
        
        _blueColor = [UIColor colorWithRed:50./255 green:130./255 blue:255./255 alpha:1.];//???
    }
    return self;
}

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController deadline:(Deadline *)deadline {
    self = [self init];
    if (self) {
        self.deadlineController = deadlineController;
        self.deadline = deadline;
        self.navigationItem.title = deadline.name;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[5] = {3, 3, 1, 1, 1};
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0)
        return 100;
    
    if(indexPath.section==0 && indexPath.row==2)
        return 200;
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //cell.textLabel.text = self.deadline.name;
            cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            
            UIImage *icon = [UIImage imageNamed:@"background1"];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            CGSize itemSize = CGSizeMake(70, 70);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            cell.textLabel.text = self.deadline.name;
            cell.textLabel.font = [UIFont systemFontOfSize:25];
            //cell.textLabel.textColor=_blueColor;
            
            NSString *detailStr=self.deadline.owner.name;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            cell.detailTextLabel.numberOfLines = 0;//要多行显示 则设置为零
            formatter.dateFormat = @"\n截止时间：yyyy/MM/dd HH:mm";
            cell.detailTextLabel.text = [detailStr stringByAppendingString:[formatter stringFromDate:self.deadline.date]];
            cell.detailTextLabel.textColor=[UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"二维码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            //cell.textLabel.text = self.deadline.owner.name;
            cell.textLabel.text = self.deadline.detail;
        }
        cell.userInteractionEnabled = NO;
    } else if (indexPath.section == 1) {
        //cell.textLabel.text = self.deadline.detail;
        //cell.userInteractionEnabled = NO;
        if(indexPath.row==0){
            cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.text=@"联系人";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor=_blueColor;
            cell.detailTextLabel.text=@"刘老师";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
        }
        else if(indexPath.row==1){
            cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.text=@"联系电话";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor=_blueColor;
            cell.detailTextLabel.text=@"18868101111";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
        }
        else{
            cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.text=@"邮箱";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor=_blueColor;
            cell.detailTextLabel.text=@"liu@hotmail.com";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"标记为完成";
        //UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        self.switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        if(self.deadline.isCompleted)
            [self.switchview setOn:YES];
        else
            [self.switchview setOn:NO];
        //switchview.tag=[indexPath row];
        [self.switchview addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = self.switchview;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    } else if (indexPath.section == 3) {
        cell.textLabel.text = @"共享给...";
        cell.textLabel.textColor = _blueColor;
        cell.textAlignment = UITextAlignmentCenter;
    }
    else if(indexPath.section==4){
        cell.textLabel.text = @"删除Deadline";
        cell.textLabel.textColor = [UIColor redColor];
        cell.textAlignment = UITextAlignmentCenter;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {//删除ddl
        //[switchView setOn:NO animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"删除该deadline？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=2;
        // optional - add more buttons:
        [alert addButtonWithTitle:@"取消"];
        [alert show];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消点击cell之后显示的灰色
}

- (void)editDeadline {
    [self.navigationController pushViewController:[[EditDeadlineController alloc] initWithDeadlineController:self.deadlineController deadline:self.deadline] animated:YES];
}

-(void) valueChanged:(UISwitch *) switchView{
    NSString *mesg;
    if ([switchView isOn]) {
        mesg=@"完成该Deadline？";
    }
    else{
        mesg=@"该Deadline未完成？";
    }
    //[switchView setOn:NO animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:mesg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.tag=1;
    // optional - add more buttons:
    [alert addButtonWithTitle:@"取消"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DeadlineModel *model = [DeadlineModel getDeadlineModel];
    if(alertView.tag==1){
        if(buttonIndex==0){
            [model completeDeadline:self.deadline.deadlineId];
            if(self.deadline.isCompleted == YES){//ddl未完成。alert出来时，switch的状态就已经变了
                self.deadlineController.dataIsChanged = YES;
                [DoneViewController setAndGetInstance:nil].dataIsChanged = YES;
            }
            else{//该ddl已完成
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            if([self.switchview isOn]){//alert出来时，switch的状态就已经变了
                [self.switchview setOn:NO];
            }
            else{
               [self.switchview setOn:YES];
            }
            //点击取消之后，switch状态不变
            //????
            //把switch弄成self的
        }
    }
    else if(alertView.tag==2){
        if(buttonIndex==0){
            [model removeDeadlineById:self.deadline.deadlineId];
            self.deadlineController.dataIsChanged = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
