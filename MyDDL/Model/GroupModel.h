//
//  GroupModel.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"
#import "GroupMessage.h"

@interface GroupModel : NSObject

@property (nonatomic) NSMutableArray<Group *> *groups;

+ (instancetype)getInstance;
- (Group *)getGroupById:(long)groupId;
- (void)changeGroup:(Group *)group;
- (void)addGroup:(Group *)group;
- (void)deleteGroup:(long)groupId;
- (void)addGroupDeadlineWithGroupId:(long)groupId deadline:(Deadline *)deadline;
- (void)deleteGroupDeadlineByGroupId:(long)groupId deadlineId:(long)deadlineId;
- (void)addGroupUserWithGroupId:(long)groupId user:(UserInfo *)user;
- (void)deleteGroupUserByGroupId:(long)groupId userId:(long)userId;
- (NSArray<GroupMessage *> *)getGroupMessages:(long)groupId;
- (Group *)getRemoteGroupById:(long)groupId;

- (void)clearData;

@end
