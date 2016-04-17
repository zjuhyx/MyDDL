//
//  ProjectDetailTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "ProjectDetailTableViewController.h"
#import "ChangeProjectController.h"

@implementation ProjectDetailTableViewController

- (NSString *)itemName {
    return @"这里将显示项目名称";
}

- (NSString *)itemImageName {
    return @"project_default";
}

- (NSString *)itemDetail {
    return @"这里将显示项目备注";
}

- (NSString *)deleteItem {
    return @"删除项目";
}

- (void)editItem {
    ChangeProjectController *changeController = [[ChangeProjectController alloc] init];
    changeController.itemName = self.itemName;
    changeController.itemImageName = self.itemImageName;
    changeController.itemDetail = self.itemDetail;
    [self.navigationController pushViewController:changeController animated:YES];
}

@end
