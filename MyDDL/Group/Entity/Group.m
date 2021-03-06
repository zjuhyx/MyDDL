//
//  Group.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/4/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Group.h"

@implementation Group

- (instancetype)init {
    self = [super init];
    self.members = [[NSMutableArray alloc] init];
    self.deadlines = [[NSMutableArray alloc] init];
    return self;
}

- (instancetype)initWithName:(NSString *)name deadlines:(NSMutableArray *)deadlines {
    self = [self init];
    self.name = name;
    self.deadlines = deadlines;
    return self;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [self init];
    self.groupId = [[json objectForKey:@"groupId"] intValue];
    self.name = [json objectForKey:@"groupName"];
    NSArray *membersJSON = [json objectForKey:@"users"];
    NSArray *deadlinesJSON = [json objectForKey:@"deadlines"];
    if (membersJSON != nil && deadlinesJSON != nil) {
        for (NSDictionary *memberJSON in membersJSON) {
            UserInfo *user = [[UserInfo alloc] initWithJSON:memberJSON];
            [self.members addObject:user];
        }
        for (NSDictionary *deadlineJSON in deadlinesJSON) {
            Deadline *deadline = [[Deadline alloc] initWithJSON:deadlineJSON];
            [self.deadlines addObject:deadline];
        }
    }
    NSString *imageNumber = [json objectForKey:@"groupImage"];
    if (imageNumber == nil) {
        self.image = 0;
    } else {
        self.image = [imageNumber intValue];
    }
    return self;
}

- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setValue:[NSString stringWithFormat:@"%ld", _groupId] forKey:@"groupId"];
    [result setValue:[NSString stringWithFormat:@"%ld", _image] forKey:@"groupImage"];
    [result setValue:_name forKey:@"groupName"];
    return result;
}

@end
