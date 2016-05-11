//
//  CourseAndProject.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseAndProject.h"

@implementation CourseAndProject

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    self.courseProjectId = [[json objectForKey:@"courseProjectId"] intValue];
    self.name = [json objectForKey:@"courseProjectName"];
    self.detail = [json objectForKey:@"courseProjectNote"];
    return self;
}

- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setValue:[NSString stringWithFormat:@"%ld", _courseProjectId] forKey:@"courseProjectId"];
    [result setValue:_name forKey:@"courseProjectName"];
    [result setValue:_detail forKey:@"courseProjectNote"];
    return result;
}

@end
