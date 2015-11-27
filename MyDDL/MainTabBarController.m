//
//  MainTabBarController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "MainTabBarController.h"
#import "UndoneViewController.h"
#import "DoneViewController.h"
#import "GroupTableViewController.h"
#import "MeTableViewController.h"
#import "Configuration.h"
#import "LoginViewController.h"
#import "Information.h"

@implementation MainTabBarController

- (instancetype)init {
    self = [super init];
    NSArray *tableViews = @[[[UndoneViewController alloc] init],
                            [[DoneViewController alloc] init],
                            [[GroupTableViewController alloc] init],
                            [[MeTableViewController alloc] init]];
    NSArray *tabTitle = @[@"未完成", @"已完成", @"小组", @"我"];
    NSArray *tabImageName = @[@"undone", @"done", @"group", @"me"];
    NSMutableArray *navigationControllers = [[NSMutableArray alloc] init];
    UIColor *themeColor = [Configuration getConfiguration].themeColor;
    for (int i = 0; i < 4; ++i) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViews[i]];
        navigationController.tabBarItem.title = tabTitle[i];
        navigationController.tabBarItem.image = [UIImage imageNamed:tabImageName[i]];
        [navigationControllers addObject:navigationController];
        UINavigationBar *navigationBar = navigationController.navigationBar;
        navigationBar.barTintColor = themeColor;
        navigationBar.tintColor = [UIColor whiteColor];
        navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        navigationBar.barStyle = UIBarStyleBlack;
    }
    self.viewControllers = navigationControllers;
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *username = [Information getInformation].username;
    if (username == nil || [username isEqualToString:@""]) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    }
}

@end
