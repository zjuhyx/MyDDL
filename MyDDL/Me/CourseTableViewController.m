//
//  CourseTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseDetailTableViewController.h"
#import "Model.h"
#import "CourseProjectModificationViewController.h"

@implementation CourseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"课程";
        Model* user=[Model getInstance];
        self.data=user.courseProjectModel.courses;
    }
    return self;
}

- (CourseDetailTableViewController *)nextViewController {
    CourseDetailTableViewController* courseDetailTableViewController=[CourseDetailTableViewController alloc];
    courseDetailTableViewController.courseAndProject=self.courseAndProject;
    return [courseDetailTableViewController init];
}

- (void)addNewItem {
    CourseProjectModificationViewController* courseProjectModificationViewController=[CourseProjectModificationViewController alloc];
    courseProjectModificationViewController.courseAndProject=self.courseAndProject;
    courseProjectModificationViewController.formTitle=@"课程";
    courseProjectModificationViewController.isCreate=YES;
    [self.navigationController pushViewController:[courseProjectModificationViewController init] animated:YES];
}

@end
