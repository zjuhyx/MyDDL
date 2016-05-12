//
//  ProjectTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "ProjectDetailTableViewController.h"
#import "Model.h"
#import "CourseProjectModificationViewController.h"

@implementation ProjectTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"项目";
        Model* user=[Model getInstance];
        self.data=user.courseProjectModel.projects;
    }
    return self;
}

- (UITableViewController *)nextViewController {
    ProjectDetailTableViewController* projectDetailTableViewController=[ProjectDetailTableViewController alloc];
    projectDetailTableViewController.courseAndProject=self.courseAndProject;
    return [projectDetailTableViewController init];
}

- (void)addNewItem {
    CourseProjectModificationViewController* courseProjectModificationViewController=[CourseProjectModificationViewController alloc];
    courseProjectModificationViewController.courseAndProject=self.courseAndProject;
    courseProjectModificationViewController.formTitle=@"项目";
    courseProjectModificationViewController.isCreate=YES;
    [self.navigationController pushViewController:[courseProjectModificationViewController init] animated:YES];
}

@end
