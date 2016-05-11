//
//  Deadline.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseAndProject.h"

@interface Deadline : NSObject

@property (nonatomic) long deadlineId;

@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *courseProjectName;
@property (nonatomic) NSString *courseProjectType;
@property (nonatomic) NSString *detail;

@property (nonatomic) BOOL isCompleted;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
