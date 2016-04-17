//
//  Deadline.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Deadline.h"

@implementation Deadline

- (instancetype)init {
    static NSInteger idAllocator = 0;
    self = [super init];
    if (self) {
        _deadlineId = idAllocator++;
    }
    return self;
}

@end
