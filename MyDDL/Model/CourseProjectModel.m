//
//  CourseProjectModel.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "CourseProjectModel.h"

@implementation CourseProjectModel

+ (instancetype)getInstance {
    static CourseProjectModel *instance = nil;
    if (instance == nil) {
        instance = [[CourseProjectModel alloc] initPrivate];
    }
    return instance;
}

- (instancetype)initPrivate {
    self = [super init];
    self.courses = [[NSMutableArray alloc] init];
    self.projects = [[NSMutableArray alloc] init];
    return self;
}

@end
