//
//  GroupModel.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"

@interface GroupModel : NSObject

@property (nonatomic) NSMutableArray<Group *> *groups;

+ (instancetype)getInstance;
- (Group *)getGroupById:(long)groupId;
- (void)changeGroup:(Group *)group;
- (void)addGroup:(Group *)group;
- (void)deleteGroup:(long)groupId;
- (void)addGroupDeadlineWithGroupId:(long)groupId deadlineId:(long)deadlineId;

@end
