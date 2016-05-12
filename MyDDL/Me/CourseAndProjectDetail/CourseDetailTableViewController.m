//
//  CourseDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseDetailTableViewController.h"
//#import "EditCourseController.h"
#import "CourseProjectModificationViewController.h"

@implementation CourseDetailTableViewController

- (NSString *)deleteItem {
    return @"删除课程";
}

- (void)editItem {
    CourseProjectModificationViewController* courseProjectModificationViewController=[CourseProjectModificationViewController alloc];
    courseProjectModificationViewController.courseAndProject=self.courseAndProject;
    courseProjectModificationViewController.formTitle=@"课程";
    courseProjectModificationViewController.isCreate=NO;
    [self.navigationController pushViewController:[courseProjectModificationViewController init] animated:YES];
    
//    EditCourseController *editController = [[EditCourseController alloc] init];
//    editController.itemName = self.courseAndProject.name;
//    //editController.itemImageName = self.courseAndProject.;
//    editController.itemDetail = self.courseAndProject.detail;
//    [self.navigationController pushViewController:editController animated:YES];
}

@end
