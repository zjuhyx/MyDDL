//
//  DeadlineModificationController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineModificationController.h"

@interface DeadlineModificationController ()

@end

@implementation DeadlineModificationController

- (instancetype)init {
    @throw [NSException exceptionWithName:@"unallowed initial method" reason:@"You should use initWithDeadlineController" userInfo:nil];
    return nil;
}

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commit)];
        _deadlineController = deadlineController;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numberOfRows[3] = {1, 2, 1};
    return numberOfRows[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.datePicker.frame.size.height;
    } else if (indexPath.section == 2) {
        return 200;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        self.datePicker = datePicker;
        datePicker.date = self.deadlineDate;
        [cell.contentView addSubview:datePicker];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 6, screenWidth - 30, 50 - 6 - 6)];
        self.nameTextField = textField;
        textField.text = self.deadlineName;
        [cell.contentView addSubview:textField];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = self.deadlineOwner.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, screenWidth - 30, 200 - 6 - 6)];
        self.detailTextView = textView;
        textView.text = self.deadlineDetail;
        [cell.contentView addSubview:textView];
    }
    return cell;
}

- (void)commit {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
