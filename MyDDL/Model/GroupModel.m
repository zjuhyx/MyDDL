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
#import "Model.h"

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
    NSMutableDictionary *parameters = [group toDictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", [Model getInstance].userInfo.userId] forKey:@"userId"];
    NSDictionary *addResult = [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
    group.groupId = [[addResult objectForKey:@"groupId"] intValue];
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

- (void)addGroupDeadlineWithGroupId:(long)groupId deadline:(Deadline *)deadline {
    Group *group = [self getGroupById:groupId];
    [group.deadlines addObject:deadline];
    
    long deadlineId = deadline.deadlineId;
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[NSString stringWithFormat:@"%ld", deadlineId] forKey:@"deadlineId"];
    [parameter setValue:[NSString stringWithFormat:@"%ld", [Model getInstance].userInfo.userId] forKey:@"userId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld/deadline", [Configuration getConfiguration].serverAddress, groupId];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameter];
}

- (void)deleteGroupDeadlineByGroupId:(long)groupId deadlineId:(long)deadlineId {
    Group *group = [self getGroupById:groupId];
    for (int i = 0; i < group.deadlines.count; ++i) {
        if (group.deadlines[i].deadlineId == deadlineId) {
            [group.deadlines removeObjectAtIndex:i];
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld/deadline/%ld/%ld", [Configuration getConfiguration].serverAddress, groupId, deadlineId, [Model getInstance].userInfo.userId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

- (void)addGroupUserWithGroupId:(long)groupId user:(UserInfo *)user {
    Group *group = [self getGroupById:groupId];
    [group.members addObject:user];
    
    long userId = user.userId;
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld", userId] forKey:@"userId"];
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld/user", [Configuration getConfiguration].serverAddress, groupId];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameter];
}

- (void)deleteGroupUserByGroupId:(long)groupId userId:(long)userId {
    Group *group = [self getGroupById:groupId];
    for (int i = 0; i < group.members.count; ++i) {
        if (group.members[i].userId == userId) {
            [group.members removeObjectAtIndex:i];
        }
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld/user/%ld", [Configuration getConfiguration].serverAddress, groupId, userId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

- (NSArray<GroupMessage *> *)getGroupMessages:(long)groupId {
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld/message", [Configuration getConfiguration].serverAddress, groupId];
    NSDictionary *jsonObject = [WebUtil webAPICallWithGetMethod:urlString];
    NSArray *messages = [jsonObject objectForKey:@"result"];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *message in messages) {
        [result addObject:[[GroupMessage alloc] initWithJSON:message]];
    }
    return result;
}

- (Group *)getRemoteGroupById:(long)groupId {
    NSString *urlString = [NSString stringWithFormat:@"%@/group/%ld", [Configuration getConfiguration].serverAddress, groupId];
    NSDictionary *json = [[WebUtil webAPICallWithGetMethod:urlString] objectForKey:@"result"];
    Group *group = [[Group alloc] initWithJSON:json];
    return group;
}

- (void)clearData {
    self.groups = [[NSMutableArray alloc] init];
}

@end
