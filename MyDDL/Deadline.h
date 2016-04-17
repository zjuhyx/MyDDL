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

@property (nonatomic, readonly) NSInteger deadlineId;

@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *date;
@property (nonatomic) CourseAndProject *owner;
@property (nonatomic) NSString *detail;

@property (nonatomic) BOOL isCompleted;

@end
