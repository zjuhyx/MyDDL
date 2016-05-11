//
//  Deadline.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Deadline.h"
#import "Course.h"
#import "Project.h"

@implementation Deadline

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    
    _deadlineId = [[json objectForKey:@"deadlineId"] intValue];
    _name = [json objectForKey:@"deadlineName"];
    _courseProjectName = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectName"];
    _courseProjectType = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectType"];
    _detail = [json objectForKey:@"deadlineNote"];
    _isCompleted = [json objectForKey:@"complete"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd/HH:mm"];
    _date = [formatter dateFromString:[json objectForKey:@"time"]];
    return self;
}

@end
