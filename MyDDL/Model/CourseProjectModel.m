//
//  CourseProjectModel.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "CourseProjectModel.h"
#import "Configuration.h"
#import "WebUtil.h"

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

- (NSMutableArray<CourseAndProject *> *)getTarget:(CourseAndProject *)courseProject {
    NSMutableArray<CourseAndProject *> *target;
    if ([courseProject isKindOfClass:[Course class]]) {
        target = self.courses;
    } else {
        target = self.projects;
    }
    return target;
}

- (void)addCourseProject:(CourseAndProject *)courseProject {
    NSMutableArray<CourseAndProject *> *target = [self getTarget:courseProject];
    [target addObject:courseProject];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/courseProject", [Configuration getConfiguration].serverAddress];
    NSDictionary *parameters = [courseProject toDictionary];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
}

- (void)changeCourseProject:(CourseAndProject *)courseProject {
    NSMutableArray<CourseAndProject *> *target = [self getTarget:courseProject];
    for (int i = 0; i < target.count; ++i) {
        if (target[i].courseProjectId == courseProject.courseProjectId) {
            target[i] = courseProject;
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/courseProject/%ld", [Configuration getConfiguration].serverAddress, courseProject.courseProjectId];
    NSDictionary *parameters = [courseProject toDictionary];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (void)deleteCourseProject:(CourseAndProject *)courseProject {
    NSMutableArray<CourseAndProject *> *target = [self getTarget:courseProject];
    for (int i = 0; i < target.count; ++i) {
        if (target[i].courseProjectId == courseProject.courseProjectId) {
            [target removeObjectAtIndex:i];
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/courseProject/%ld", [Configuration getConfiguration].serverAddress, courseProject.courseProjectId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

- (void)clearData {
    self.courses = [[NSMutableArray alloc] init];
    self.projects = [[NSMutableArray alloc] init];
}

@end
