//
//  DeadlineDetail.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/10/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deadline : NSObject

@property (nonatomic) long deadlineId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSDate *date;
@property (nonatomic) long courseProjectId;
@property (nonatomic) NSString *courseProjectName;
@property (nonatomic) NSString *courseProjectType;
@property (nonatomic) NSString *contactName;
@property (nonatomic) NSString *contactPhone;
@property (nonatomic) NSString *contactEmail;
@property (nonatomic) NSString *detail;
@property (nonatomic) long image;
@property (nonatomic) bool isCompleted;

- (instancetype)initWithJSON:(NSDictionary *)json;
- (NSMutableDictionary *)toDictionary;

@end
