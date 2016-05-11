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
//    self.userImage = [json objectForKey:@"userImage"];
    self.userPhone = [json objectForKey:@"userPhone"];
    self.userEmail = [json objectForKey:@"userEmail"];
    self.mainScreenImage = [[json objectForKey:@"mainScreenImage"] intValue];
    return self;
}

@end
