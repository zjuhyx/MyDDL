//
//  DeadlineDetail.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/10/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "Deadline.h"
#import "Configuration.h"

@implementation Deadline

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [self init];
    
    _deadlineId = [[json objectForKey:@"deadlineId"] intValue];
    _name = [json objectForKey:@"deadlineName"];
    _courseProjectId = [[[json objectForKey:@"courseProject"] objectForKey:@"courseProjectId"] intValue];
    _courseProjectName = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectName"];
    _courseProjectType = [[json objectForKey:@"courseProject"] objectForKey:@"courseProjectType"];
    _contactName = [json objectForKey:@"contactName"];
    _contactPhone = [json objectForKey:@"contactPhone"];
    _contactEmail = [json objectForKey:@"contactEmail"];
    _detail = [json objectForKey:@"deadlineNote"];
    _isCompleted = [[json objectForKey:@"complete"] intValue];
    
    NSString *imageNumber = [json objectForKey:@"deadlineImage"];
    if (imageNumber == nil) {
        self.image = 0;
    } else {
        self.image = [imageNumber intValue];
    }
    
    NSDateFormatter *formatter = [Configuration getConfiguration].formatter;
    _date = [formatter dateFromString:[json objectForKey:@"time"]];
    
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setValue:[NSString stringWithFormat:@"%ld", _deadlineId] forKey:@"deadlineId"];
    [result setValue:_name forKey:@"deadlineName"];
    [result setValue:[NSString stringWithFormat:@"%ld", _courseProjectId] forKey:@"courseProjectId"];
    [result setValue:_contactName forKey:@"contactName"];
    [result setValue:_contactPhone forKey:@"contactPhone"];
    [result setValue:_contactEmail forKey:@"contactEmail"];
    [result setValue:_detail forKey:@"deadlineNote"];
    
    NSString *complete = _isCompleted ? @"true" : @"false";
    [result setValue:complete forKey:@"complete"];
    
    [result setValue:[NSString stringWithFormat:@"%ld", _image] forKey:@"deadlineImage"];
    
    NSDateFormatter *formatter = [Configuration getConfiguration].formatter;
    NSString *time = [formatter stringFromDate:_date];
    [result setValue:time forKey:@"time"];
    return result;
}

@end
