//
//  Model.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "Model.h"
#import "WebUtil.h"

@interface Model ()

@end

@implementation Model

- (instancetype)initPrivate {
    self = [super init];
    self.deadlineModel = [DeadlineModel getDeadlineModel];
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
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/user/login?username=%@&password=%@", username, password];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    NSDictionary *jsonObject = [WebUtil webAPICallWithRequest:request];
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
    // todo
    return true;
}

- (void)loadUserWithId:(long) userId {
    
}

@end
