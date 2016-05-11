//
//  Model.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "DeadlineModel.h"
#import "GroupModel.h"
#import "CourseProjectModel.h"
#import "Configuration.h"

@interface Model : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) UserInfo *userInfo;
@property (nonatomic) DeadlineModel *deadlineModel;
@property (nonatomic) GroupModel *groupModel;
@property (nonatomic) CourseProjectModel *courseProjectModel;
@property (nonatomic) Configuration *configuration;

- (void)clearData;
+ (instancetype)getInstance;
- (bool)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)changeUserInfo:(UserInfo *)user;
- (void)changeUserPassword:(NSString *)password;
- (void)signUp:(NSString *)username password:(NSString *)password userName:(NSString *)userName;
- (NSArray<Deadline *> *)getPushDeadlines;
- (void)rejectPushDeadline:(long)deadlineId;
- (void)receivePushDeadline:(Deadline *)deadline;

@end
