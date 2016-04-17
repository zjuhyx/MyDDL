//
//  ProjectTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "ProjectDetailTableViewController.h"
#import "AddProjectController.h"

@implementation ProjectTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"项目";
    }
    return self;
}

- (UITableViewController *)nextViewController {
    return [[ProjectDetailTableViewController alloc] init];
}

- (UIImage *)cellImageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:@"project_default"];
}

- (void)addNewItem {
    [self.navigationController pushViewController:[[AddProjectController alloc] init] animated:YES];
}

@end
