//
//  ChangeCourseController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "EditCourseController.h"

@implementation EditCourseController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"修改课程";
    }
    return self;
}

- (void)commit {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
