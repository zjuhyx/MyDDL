//
//  Group.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/4/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deadline.h"
#import "UserInfo.h"

@interface Group : NSObject

@property (nonatomic) long groupId;
@property (nonatomic) NSString *name;
@property (nonatomic) long image;
@property (nonatomic) NSMutableArray<Deadline *> *deadlines;
@property (nonatomic) NSMutableArray<UserInfo *> *members;

- (instancetype)initWithName:(NSString *)name deadlines:(NSArray *)deadlines;
- (instancetype)initWithJSON:(NSDictionary *)json;
- (NSDictionary *)toDictionary;

@end
