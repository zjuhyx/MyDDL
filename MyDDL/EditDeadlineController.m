//
//  EditDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "EditDeadlineController.h"
#import "DeadlineModel.h"

@implementation EditDeadlineController

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController deadline:(Deadline *)deadline {
    self = [super initWithDeadlineController:deadlineController];
    if (self) {
        self.deadline = deadline;
        self.navigationItem.title = [[NSString alloc] initWithFormat:@"编辑%@", deadline.name];
    }
    return self;
}

- (NSString *)deadlineName {
    return self.deadline.name;
}

- (NSDate *)deadlineDate {
    return self.deadline.date;
}

- (NSString *)deadlineDetail {
    return self.deadline.detail;
}

- (void)commit {
    DeadlineModel *deadlineModel = [DeadlineModel getDeadlineModel];
    Deadline *editedDeadline = self.deadline;
    editedDeadline.name = self.nameTextField.text;
    editedDeadline.date = self.datePicker.date;
    editedDeadline.detail = self.detailTextView.text;
    [deadlineModel changeDeadline:editedDeadline];
    self.deadlineController.dataIsChanged = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
