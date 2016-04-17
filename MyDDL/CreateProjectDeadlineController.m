//
//  CreateProjectDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CreateProjectDeadlineController.h"
#import "Project.h"

@implementation CreateProjectDeadlineController

- (CourseAndProject *)deadlineOwner {
    return [[Project alloc] initWithName:@"testProject"];
}

@end
