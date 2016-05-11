//
//  CreateDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/30/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CreateDeadlineController.h"
#import "DeadlineModel.h"
#import "Course.h"
#import "Project.h"

@interface CreateDeadlineController ()

@end

@implementation CreateDeadlineController

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController {
    self = [super initWithDeadlineController:deadlineController];
    if (self) {
        self.navigationItem.title = @"创建deadline";
    }
    return self;
}

- (NSString *)deadlineName {
    return nil;
}

- (NSString *)deadlineDetail {
    return nil;
}

- (NSDate *)deadlineDate {
    return [NSDate date];
}

- (NSString *)deadlineContactName {
    return nil;
}

- (NSString *)deadlineContactPhone {
    return nil;
}

- (NSString *)deadlineContactEmail {
    return nil;
}

- (void)commit {
    DeadlineModel *deadlineModel = [DeadlineModel getDeadlineModel];
    Deadline *newDeadline = [[Deadline alloc] init];
    newDeadline.name = self.nameTextField.text;
    newDeadline.date = self.datePicker.date;
    newDeadline.detail = self.detailTextView.text;
    [deadlineModel addDeadline:newDeadline];
    self.deadlineController.dataIsChanged = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
