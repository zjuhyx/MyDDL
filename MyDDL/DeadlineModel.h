//
//  DeadlineModel.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deadline.h"

@interface DeadlineModel : NSObject

@property (nonatomic, readonly) NSArray<Deadline *> *allUndoneDeadlines;
@property (nonatomic, readonly) NSArray<Deadline *> *allDoneDeadlines;
@property (nonatomic) NSMutableArray<Deadline *> *allDeadlines;

- (void)clearData;
+ (instancetype)getDeadlineModel;
- (void)addDeadline:(Deadline *)deadline;
- (Deadline *)getDeadlineById:(long)deadlineId;
- (void)changeDeadline:(Deadline *)deadline;
- (void)removeDeadlineById:(NSInteger)deadlineId;
- (void)completeDeadline:(NSInteger)deadlineId;

@end
