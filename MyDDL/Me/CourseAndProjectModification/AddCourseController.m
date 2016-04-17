//
//  AddCourseController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "AddCourseController.h"

@implementation AddCourseController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"添加课程";
    }
    return self;
}

- (NSString *)itemName {
    return @"课程名称";
}

- (NSString *)itemImageName {
    return @"course_default";
}

- (NSString *)itemDetail {
    return @"课程备注";
}

- (void)commit {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
