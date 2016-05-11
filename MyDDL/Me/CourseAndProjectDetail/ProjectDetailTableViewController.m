//
//  ProjectDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "ProjectDetailTableViewController.h"
#import "EditProjectController.h"

@implementation ProjectDetailTableViewController

//- (NSString *)itemImageName {
//    return @"project_default";
//}

- (NSString *)itemDetail {
    return @"项目备注";
}

- (NSString *)deleteItem {
    return @"删除项目";
}

//直接来一个type好了。。
- (NSString *)cpType {
    return @"项目";
}

- (void)editItem {
    EditProjectController *editController = [[EditProjectController alloc] init];
    editController.itemName = self.courseAndProject.name;
    //editController.itemImageName = self.itemImageName;
    editController.itemDetail = self.courseAndProject.detail;
    [self.navigationController pushViewController:editController animated:YES];
}

@end
