//
//  Model.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "Model.h"
#import "WebUtil.h"
#import "Course.h"
#import "Project.h"

@interface Model ()

@end

@implementation Model

- (void)clearData {
    self.username = nil;
    self.userInfo = nil;
    [self.deadlineModel clearData];
}

- (instancetype)initPrivate {
    self = [super init];
    self.deadlineModel = [DeadlineModel getDeadlineModel];
    self.groupModel = [GroupModel getInstance];
    self.courseProjectModel = [CourseProjectModel getInstance];
    self.configuration = [Configuration getConfiguration];
    return self;
}

+ (instancetype)getInstance {
    static Model *instance = nil;
    if (instance == nil) {
        instance = [[Model alloc] initPrivate];
    }
    return instance;
}

- (bool)loginWithUsername:(NSString *)username password:(NSString *)password {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/login?username=%@&password=%@", self.configuration.serverAddress, username, password];
    NSDictionary *jsonObject = [WebUtil webAPICallWithGetMethod:urlString];
    if ([[jsonObject objectForKey:@"statusCode"] intValue] != 200) {
        return false;
    }
    NSDictionary *jsonResult = [jsonObject objectForKey:@"result"];
    
    self.username = [NSString stringWithString:username];
    self.userInfo = [[UserInfo alloc] init];
    UserInfo *userInfo = self.userInfo;
    userInfo.userId = [[jsonResult objectForKey:@"userId"] longValue];
    userInfo.userName = [jsonResult objectForKey:@"userName"];
    userInfo.userImage = [jsonResult objectForKey:@"userImage"];
    userInfo.userPhone = [jsonResult objectForKey:@"userPhone"];
    userInfo.userEmail = [jsonResult objectForKey:@"userEmail"];
    userInfo.mainScreenImage = [[jsonResult objectForKey:@"mainScreenImage"] intValue];
    
    NSArray *deadlines = [jsonResult objectForKey:@"deadlines"];
    for (NSDictionary *deadline in deadlines) {
        [self.deadlineModel addDeadline:[[Deadline alloc] initWithJSON:deadline]];
    }
    NSArray *groups = [jsonResult objectForKey:@"groups"];
    for (NSDictionary *group in groups) {
        [self.groupModel.groups addObject:[[Group alloc] initWithJSON:group]];
    }
    NSArray *courseProjects = [jsonResult objectForKey:@"courseProjects"];
    for (NSDictionary *courseProject in courseProjects) {
        NSString *type = [courseProject objectForKey:@"courseProjectType"];
        if ([type compare:@"course"] == NSOrderedSame) {
            [self.courseProjectModel.courses addObject:[[Course alloc] initWithJSON:courseProject]];
        } else {
            [self.courseProjectModel.projects addObject:[[Project alloc] initWithJSON:courseProject]];
        }
    }
    return true;
}

- (void)loadUserWithId:(long) userId {
    
}

@end
