//
//  DeadlineDetail.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/10/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "Deadline.h"

@implementation Deadline

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [self init];
    
    _deadlineId = [[json objectForKey:@"deadlineId"] intValue];
    _name = [json objectForKey:@"deadlineName"];
    _courseProjectName = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectName"];
    _courseProjectType = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectType"];
    _contactName = [json objectForKey:@"contactName"];
    _contactPhone = [json objectForKey:@"contactPhone"];
    _contactEmail = [json objectForKey:@"contactEmail"];
    _detail = [json objectForKey:@"deadlineNote"];
    _isCompleted = [[json objectForKey:@"complete"] intValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd/HH:mm"];
    _date = [formatter dateFromString:[json objectForKey:@"time"]];
    
    
    return self;
}

@end
