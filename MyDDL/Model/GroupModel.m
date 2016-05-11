//
//  GroupModel.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "GroupModel.h"
#import "Configuration.h"
#import "WebUtil.h"

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

- (Group *)getGroupDetailById:(long)groupId {
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld", [Configuration getConfiguration].serverAddress, groupId];
    NSDictionary *jsonObject = [WebUtil webAPICallWithGetMethod:urlString];
    NSDictionary *json = [jsonObject objectForKey:@"result"];
    return [[Group alloc] initWithJSON:json];
}

- (void)changeGroup:(Group *)group {
    for (int i = 0; i < self.groups.count; ++i) {
        if (self.groups[i].groupId == group.groupId) {
            self.groups[i] = group;
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld", [Configuration getConfiguration].serverAddress, group.groupId];
    NSDictionary *parameters = [group toDictionary];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (void)addGroup:(Group *)group {
    [self.groups addObject:group];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group", [Configuration getConfiguration].serverAddress];
    NSDictionary *parameters = [group toDictionary];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
}

- (void)deleteGroup:(long)groupId {
    for (int i = 0; i < self.groups.count; ++i) {
        if (self.groups[i].groupId == groupId) {
            [self.groups removeObjectAtIndex:i];
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld", [Configuration getConfiguration].serverAddress, groupId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

@end
