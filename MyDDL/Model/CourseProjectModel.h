//
//  CourseProjectModel.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseAndProject.h"
#import "Course.h"
#import "Project.h"

@interface CourseProjectModel : NSObject

@property (nonatomic) NSMutableArray<CourseAndProject *> *courses;
@property (nonatomic) NSMutableArray<CourseAndProject *> *projects;

+ (instancetype)getInstance;
- (void)addCourseProject:(CourseAndProject *)courseProject;
- (void)changeCourseProject:(CourseAndProject *)courseProject;
- (void)deleteCourseProject:(CourseAndProject *)courseProject;
- (CourseAndProject *)getCourseProjectById:(long)courseProjectId;

- (void)clearData;

@end
