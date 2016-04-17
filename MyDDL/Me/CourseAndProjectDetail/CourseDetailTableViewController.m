//
//  CourseDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "ChangeCourseController.h"

@implementation CourseDetailTableViewController

- (NSString *)itemName {
    return @"这里将显示课程名称";
}

- (NSString *)itemImageName {
    return @"course_default";
}

- (NSString *)itemDetail {
    return @"这里将显示课程备注";
}

- (NSString *)deleteItem {
    return @"删除课程";
}

- (void)editItem {
    ChangeCourseController *changeController = [[ChangeCourseController alloc] init];
    changeController.itemName = self.itemName;
    changeController.itemImageName = self.itemImageName;
    changeController.itemDetail = self.itemDetail;
    [self.navigationController pushViewController:changeController animated:YES];
}

@end
