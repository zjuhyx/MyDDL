//
//  Group.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/4/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Group.h"

@implementation Group

- (instancetype)initWithName:(NSString *)name deadline:(Deadline *)deadline {
    self = [super init];
    if (self) {
        self.name = name;
        self.deadline = deadline;
    }
    return self;
}

@end
