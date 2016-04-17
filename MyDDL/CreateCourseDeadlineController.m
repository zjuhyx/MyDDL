//
//  CreateCourseDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/30/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CreateCourseDeadlineController.h"
#import "Course.h"

@implementation CreateCourseDeadlineController

- (CourseAndProject *)deadlineOwner {
    return [[Course alloc] initWithName:@"testCourse"];
}

@end
