//
//  UserInfo.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    self.userId = [[json objectForKey:@"userId"] longValue];
    self.userName = [json objectForKey:@"userName"];
    NSString *imageNumber = [json objectForKey:@"userImage"];
    if (imageNumber == nil) {
        self.userImageId = 0;
    } else {
        self.userImageId = [imageNumber intValue];
    }
    self.userPhone = [json objectForKey:@"userPhone"];
    self.userEmail = [json objectForKey:@"userEmail"];
    self.mainScreenImage = [[json objectForKey:@"mainScreenImage"] intValue];
    return self;
}

- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setValue:[NSString stringWithFormat:@"%ld", _userId] forKey:@"userId"];
    [result setValue:_userName forKey:@"userName"];
    [result setValue:_userPhone forKey:@"userPhone"];
    [result setValue:_userEmail forKey:@"userEmail"];
    [result setValue:[NSString stringWithFormat:@"%ld", _userImageId] forKey:@"userImage"];
    [result setValue:[NSString stringWithFormat:@"%d", _mainScreenImage] forKey:@"mainScreenImage"];
    return result;
}

@end
