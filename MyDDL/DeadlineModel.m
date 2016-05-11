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

@interface DeadlineModel ()

@property (nonatomic) NSMutableArray<Deadline *> *allDeadlines;

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
    
//    // for test
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    
//    Deadline *deadline1 = [[Deadline alloc] init];
//    deadline1.name = @"testDeadline";
//    deadline1.date = [formatter dateFromString:@"2015-12-03 13:30"];
//    deadline1.owner = [[Course alloc] initWithName:@"testCourse"];
//    deadline1.detail = @"testDetail";
//    deadline1.isCompleted = NO;
//    
//    Deadline *deadline2 = [[Deadline alloc] init];
//    deadline2.name = @"testDeadline2";
//    deadline2.date = [formatter dateFromString:@"2015-12-04 17:50"];
//    deadline2.owner = [[Project alloc] initWithName:@"testProject"];
//    deadline2.detail = @"testDetail";
//    deadline2.isCompleted = NO;
//    
//    Deadline *deadline3 = [[Deadline alloc] init];
//    deadline3.name = @"testDeadline3";
//    deadline3.date = [formatter dateFromString:@"2015-12-11 13:30"];
//    deadline3.owner = [[Course alloc] initWithName:@"testCourse2"];
//    deadline3.detail = @"testDetail";
//    deadline3.isCompleted = NO;
//    
//    Deadline *deadline4 = [[Deadline alloc] init];
//    deadline4.name = @"testDeadline4";
//    deadline4.date = [formatter dateFromString:@"2016-01-04 13:30"];
//    deadline4.owner = [[Course alloc] initWithName:@"testCourse2"];
//    deadline4.detail = @"testDetail";
//    deadline4.isCompleted = YES;
//    
//    Deadline *deadline5 = [[Deadline alloc] init];
//    deadline5.name = @"testDeadline5";
//    deadline5.date = [formatter dateFromString:@"2016-3-04 13:30"];
//    deadline5.owner = [[Course alloc] initWithName:@"testCourse2"];
//    deadline5.detail = @"testDetail";
//    deadline5.isCompleted = NO;
//    
//    Deadline *deadline6 = [[Deadline alloc] init];
//    deadline6.name = @"testDeadline6";
//    deadline6.date = [formatter dateFromString:@"2016-12-04 13:30"];
//    deadline6.owner = [[Course alloc] initWithName:@"testCourse2"];
//    deadline6.detail = @"testDetail";
//    deadline6.isCompleted = NO;
//    
//    [_allDeadlines addObject:deadline1];
//    [_allDeadlines addObject:deadline2];
//    [_allDeadlines addObject:deadline3];
//    [_allDeadlines addObject:deadline4];
//    [_allDeadlines addObject:deadline5];
//    [_allDeadlines addObject:deadline6];
    
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
}

- (void)removeDeadlineById:(NSInteger)deadlineId {
    for (int i = 0; i < self.allDeadlines.count; i++) {
        if (self.allDeadlines[i].deadlineId == deadlineId) {
            [self.allDeadlines removeObjectAtIndex:i];
        }
    }
}

- (void)completeDeadline:(NSInteger)deadlineId {
    for (int i = 0; i < self.allDeadlines.count; i++) {
        if (self.allDeadlines[i].deadlineId == deadlineId) {
            self.allDeadlines[i].isCompleted = YES;
        }
    }
}


- (DeadlineDetail *)getDeadlineDetailById:(long)deadlineId {
    NSString *urlString = [NSString stringWithFormat:@"%@/deadline/%ld", [Configuration getConfiguration].serverAddress, deadlineId];
    NSDictionary *jsonResult = [[WebUtil webAPICallWithGetMethod:urlString] objectForKey:@"result"];
    return [[DeadlineDetail alloc] initWithJSON:jsonResult];
}

@end
