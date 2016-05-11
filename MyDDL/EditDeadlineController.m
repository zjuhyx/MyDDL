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
        [self afterInit];
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

- (NSString *)deadlineContactName {
    return self.deadline.contactName;
}

- (NSString *)deadlineContactPhone {
    return self.deadline.contactPhone;
}

- (NSString *)deadlineContactEmail {
    return self.deadline.contactEmail;
}

- (void)commit {
    DeadlineModel *deadlineModel = [DeadlineModel getDeadlineModel];
    Deadline *editedDeadline = self.deadline;
    editedDeadline.name = [self.form formRowWithTag:@"title"].value;
    editedDeadline.date = [self.form formRowWithTag:@"date"].value;
    editedDeadline.detail = [self.form formRowWithTag:@"detail"].value;
    //NSLog(@"%@, %@", [self.form formRowWithTag:@"date"].value, [self.form formRowWithTag:@"time"].value);
    //"date"和"time"是一样的
    [deadlineModel changeDeadline:editedDeadline];
    self.deadlineController.dataIsChanged = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
