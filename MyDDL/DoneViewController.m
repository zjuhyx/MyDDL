//
//  DoneTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DoneViewController.h"
#import "DeadlineModel.h"

#import "SearchDeadlineController.h"
#import "DeleteDeadlineViewController.h"

@implementation DoneViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"已完成";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchDeadline)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteDoneDeadline)];
    }
    [DoneViewController setAndGetInstance:self];
    return self;
}

+ (DoneViewController *)setAndGetInstance:(DoneViewController *)doneViewController {
    static DoneViewController *instance = nil;
    if (doneViewController != nil) {
        instance = doneViewController;
    }
    return instance;
}

- (NSArray<Deadline *> *)deadlines {
    return [DeadlineModel getDeadlineModel].allDoneDeadlines;
}

- (void)searchDeadline {
    [self.navigationController pushViewController:[[SearchDeadlineController alloc] init] animated:YES];
}

- (void)deleteDoneDeadline {
    DeleteDeadlineViewController* deleteViewController=[[DeleteDeadlineViewController alloc] init];
    deleteViewController.deadlineController=self;
    [self.navigationController pushViewController:deleteViewController animated:YES];
}

@end
