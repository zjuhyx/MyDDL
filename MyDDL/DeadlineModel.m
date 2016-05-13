//
//  DeadlineModel.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineModel.h"
#import "Course.h"
#import "Project.h"
#import "WebUtil.h"
#import "Configuration.h"
#import "Model.h"

@interface DeadlineModel ()

@end

@implementation DeadlineModel

- (void)clearData {
    self.allDeadlines = [[NSMutableArray alloc] init];
}

+ (instancetype)getDeadlineModel {
    static DeadlineModel *instance = nil;
    if (instance == nil) {
        instance = [[DeadlineModel alloc] initPrivate];
    }
    return instance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.allDeadlines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Can not create a instance of this class" userInfo:nil];
    return nil;
}

- (NSArray *)allUndoneDeadlines {
    NSMutableArray *allUndoneDeadline = [[NSMutableArray alloc] init];
    for (Deadline *deadline in self.allDeadlines) {
        if (!deadline.isCompleted) {
            [allUndoneDeadline addObject:deadline];
        }
    }
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSSortDescriptor *idDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deadlineId" ascending:YES];
    [allUndoneDeadline sortUsingDescriptors:@[dateDescriptor, idDescriptor]];
    return allUndoneDeadline;
}

- (NSArray *)allDoneDeadlines {
    NSMutableArray *allDoneDeadline = [[NSMutableArray alloc] init];
    for (Deadline *deadline in self.allDeadlines) {
        if (deadline.isCompleted) {
            [allDoneDeadline addObject:deadline];
        }
    }
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSSortDescriptor *idDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deadlineId" ascending:YES];
    [allDoneDeadline sortUsingDescriptors:@[dateDescriptor, idDescriptor]];
    return allDoneDeadline;
}

- (void)addDeadline:(Deadline *)deadline {
    [self.allDeadlines addObject:deadline];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline", [Configuration getConfiguration].serverAddress];
    NSMutableDictionary *parameters = [deadline toDictionary];
    [parameters setValue:[NSString stringWithFormat:@"%ld", [Model getInstance].userInfo.userId] forKey:@"userId"];
    NSDictionary *addResult = [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
    deadline.deadlineId = [[addResult objectForKey:@"deadlineId"] intValue];
}

- (Deadline *)getDeadlineById:(long)deadlineId {
    for (Deadline *deadline in self.allDeadlines) {
        if (deadline.deadlineId == deadlineId) {
            return deadline;
        }
    }
    return nil;
}

- (void)changeDeadline:(Deadline *)deadline {
    for (int i = 0; i < self.allDeadlines.count; i++) {
        if (self.allDeadlines[i].deadlineId == deadline.deadlineId) {
            self.allDeadlines[i] = deadline;
        }
    }
    NSDictionary *parameters = [deadline toDictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline/%ld", [Configuration getConfiguration].serverAddress, deadline.deadlineId];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (void)removeDeadlineById:(long)deadlineId {
    for (int i = 0; i < self.allDeadlines.count; i++) {
        if (self.allDeadlines[i].deadlineId == deadlineId) {
            [self.allDeadlines removeObjectAtIndex:i];
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline/%ld", [Configuration getConfiguration].serverAddress, deadlineId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

- (void)completeDeadline:(long)deadlineId {
    for (int i = 0; i < self.allDeadlines.count; i++) {
        if (self.allDeadlines[i].deadlineId == deadlineId) {
            self.allDeadlines[i].isCompleted = YES;
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline/%ld", [Configuration getConfiguration].serverAddress, deadlineId];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"complete" forKey:@"true"];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (Deadline *)getRemoteDeadlineById:(long)deadlineId {
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline/%ld", [Configuration getConfiguration].serverAddress, deadlineId];
    NSDictionary *json = [[WebUtil webAPICallWithGetMethod:urlString] objectForKey:@"result"];
    Deadline *deadline = [[Deadline alloc] initWithJSON:json];
    return deadline;
}


@end
