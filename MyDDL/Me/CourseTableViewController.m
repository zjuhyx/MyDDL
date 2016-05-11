//
//  CourseTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseDetailTableViewController.h"
#import "AddCourseController.h"
#import "Model.h"

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
    return [[CourseDetailTableViewController alloc] init];
}

//- (UIImage *)cellImageAtIndexPath:(NSIndexPath *)indexPath {
//    return [UIImage imageNamed:@"course_default"];
//}

- (void)addNewItem {
    [self.navigationController pushViewController:[[AddCourseController alloc] init] animated:YES];
}

@end
