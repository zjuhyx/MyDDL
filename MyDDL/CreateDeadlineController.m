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
#import "CourseProjectModel.h"
#import "Model.h"

@interface CreateDeadlineController ()

@end

@implementation CreateDeadlineController

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController {
    self = [super initWithDeadlineController:deadlineController];
    if (self) {
        self.navigationItem.title = @"创建deadline";
        [self afterInit];
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
    newDeadline.name = [self.form formRowWithTag:@"title"].value;
    newDeadline.image = [[Model getInstance] addOriginalImage:[self.form formRowWithTag:@"image"].value];
    newDeadline.date = [self.form formRowWithTag:@"date"].value;
    newDeadline.detail = [self.form formRowWithTag:@"detail"].value;
    newDeadline.contactName = [self.form formRowWithTag:@"contact"].value;
    newDeadline.contactPhone = [self.form formRowWithTag:@"phone"].value;
    newDeadline.contactEmail = [self.form formRowWithTag:@"email"].value;
    newDeadline.courseProjectName=[self.form formRowWithTag:@"kSelectorLeftRight"].value;
    CourseAndProject* tmp=[[CourseProjectModel getInstance] getCourseProjectByName:newDeadline.courseProjectName];
    newDeadline.courseProjectId=tmp.courseProjectId;
    if([[self.form formRowWithTag:@"kSelectorLeftRight"].title isEqualToString:@"课程"]){
        newDeadline.courseProjectType=@"course";
    }
    else{
        newDeadline.courseProjectType=@"project";
    }
    
    [deadlineModel addDeadline:newDeadline];
    self.deadlineController.dataIsChanged = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
