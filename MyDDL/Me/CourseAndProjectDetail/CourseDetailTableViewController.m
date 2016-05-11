//
//  CourseDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "EditCourseController.h"

@implementation CourseDetailTableViewController

//- (NSString *)itemImageName {
//    return @"course_default";
//}

- (NSString *)itemDetail {
    return @"课程备注";
}

- (NSString *)deleteItem {
    return @"删除课程";
}

- (void)editItem {
    EditCourseController *editController = [[EditCourseController alloc] init];
    editController.itemName = self.courseAndProject.name;
    //editController.itemImageName = self.courseAndProject.;
    editController.itemDetail = self.courseAndProject.detail;
    [self.navigationController pushViewController:editController animated:YES];
}

@end
