//
//  Group.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/4/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Group.h"

@implementation Group

- (instancetype)initWithName:(NSString *)name deadlines:(NSArray *)deadlines {
    self = [self init];
    self.name = name;
    self.deadlines = deadlines;
    return self;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [self init];
    self.groupId = [[json objectForKey:@"groupId"] intValue];
    self.name = [json objectForKey:@"groupName"];
    return self;
}

@end
