//
//  ProjectDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "ProjectDetailTableViewController.h"
//#import "EditProjectController.h"
#import "CourseProjectModificationViewController.h"

@implementation ProjectDetailTableViewController

- (NSString *)deleteItem {
    return @"删除项目";
}

- (void)editItem {
    CourseProjectModificationViewController* courseProjectModificationViewController=[CourseProjectModificationViewController alloc];
    courseProjectModificationViewController.courseAndProject=self.courseAndProject;
    courseProjectModificationViewController.formTitle=@"项目";
    courseProjectModificationViewController.isCreate=NO;
    [self.navigationController pushViewController:[courseProjectModificationViewController init] animated:YES];
    
//    EditProjectController *editController = [[EditProjectController alloc] init];
//    editController.itemName = self.courseAndProject.name;
//    //editController.itemImageName = self.itemImageName;
//    editController.itemDetail = self.courseAndProject.detail;
//    [self.navigationController pushViewController:editController animated:YES];
}

@end
