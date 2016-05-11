//
//  GroupModel.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

+ (instancetype)getInstance {
    static GroupModel *instance = nil;
    if (instance == nil) {
        instance = [[GroupModel alloc] initPrivate];
    }
    return instance;
}

- (instancetype)initPrivate {
    self = [super init];
    self.groups = [[NSMutableArray alloc] init];
    return self;
}

- (Group *)getGroupById:(long)groupId {
    for (Group *group in self.groups) {
        if (group.groupId == groupId) {
            return group;
        }
    }
    return nil;
}

@end
