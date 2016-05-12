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
#import "Model.h"

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
    NSMutableDictionary *parameters = [courseProject toDictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", [Model getInstance].userInfo.userId] forKey:@"userId"];
    NSDictionary *addResult = [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
    courseProject.courseProjectId = [[addResult objectForKey:@"courseProjectId"] intValue];
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

- (CourseAndProject *)getCourseProjectById:(long)courseProjectId {
    for (int i = 0; i < self.courses.count; ++i) {
        if (self.courses[i].courseProjectId == courseProjectId) {
            return self.courses[i];
        }
    }
    for (int i = 0; i < self.projects.count; ++i) {
        if (self.projects[i].courseProjectId == courseProjectId) {
            return self.projects[i];
        }
    }
    return nil;
}

- (CourseAndProject *)getCourseProjectByName:(NSString *)name {
    for (int i = 0; i < self.courses.count; ++i) {
        if ([self.courses[i].name compare:name] == NSOrderedSame) {
            return self.courses[i];
        }
    }
    for (int i = 0; i < self.projects.count; ++i) {
        if ([self.projects[i].name compare:name] == NSOrderedSame) {
            return self.projects[i];
        }
    }
    return nil;
}

- (NSMutableArray<Deadline *> *)getDeadlinesByCourseProjectId:(long)courseProjectId {
    NSString *urlString = [NSString stringWithFormat:@"%@/courseProject/%ld", [Configuration getConfiguration].serverAddress, courseProjectId];
    NSDictionary *jsonObject = [WebUtil webAPICallWithGetMethod:urlString];
    NSDictionary *json = [jsonObject objectForKey:@"result"];
    NSArray *deadlinesJSON = [json objectForKey:@"deadlines"];
    NSMutableArray<Deadline *> *result = [[NSMutableArray alloc] init];
    for (NSDictionary *deadlineJSON in deadlinesJSON) {
        [result addObject:[[Deadline alloc] initWithJSON:deadlineJSON]];
    }
    return result;
}

- (void)clearData {
    self.courses = [[NSMutableArray alloc] init];
    self.projects = [[NSMutableArray alloc] init];
}

@end
