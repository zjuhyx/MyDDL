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
    [self.groupModel clearData];
    [self.courseProjectModel clearData];
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
    self.userInfo = [[UserInfo alloc] initWithJSON:jsonResult];
    
    NSArray *deadlines = [jsonResult objectForKey:@"deadlines"];
    for (NSDictionary *deadline in deadlines) {
        [self.deadlineModel.allDeadlines addObject:[[Deadline alloc] initWithJSON:deadline]];
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

- (void)changeUserInfo:(UserInfo *)user {
    self.userInfo = user;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/user/%ld", self.configuration.serverAddress, self.userInfo.userId];
    NSDictionary *parameters = [user toDictionary];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (void)changeUserPassword:(NSString *)password {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/%ld", self.configuration.serverAddress, self.userInfo.userId];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:password forKey:@"password"];
    [WebUtil webAPICallWithPostMethod:urlString parameters:parameters];
}

- (void)signUp:(NSString *)username password:(NSString *)password userName:(NSString *)userName {
    NSString *urlString = [NSString stringWithFormat:@"%@/user", self.configuration.serverAddress];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:username forKey:@"username"];
    [parameters setValue:password forKey:@"password"];
    [parameters setValue:userName forKey:@"userName"];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
    [self loginWithUsername:username password:password];
}

- (NSArray<Deadline *> *)getPushDeadlines {
    NSMutableArray<Deadline *> *result = [[NSMutableArray alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@/user/%ld/pushDeadline", [Configuration getConfiguration].serverAddress, self.userInfo.userId];
    NSDictionary *jsonObject = [WebUtil webAPICallWithGetMethod:urlString];
    NSArray *pushDeadlinesJSON = [jsonObject objectForKey:@"result"];
    for (NSDictionary *pushDeadlineJSON in pushDeadlinesJSON) {
        Deadline *deadline = [[Deadline alloc] initWithJSON:pushDeadlineJSON];
        [result addObject:deadline];
    }
    return result;
}

- (void)deletePushDeadline:(long)deadlineId {
    NSString *urlString = [NSString stringWithFormat:@"%@/user/%ld/pushDeadline/%ld", [Configuration getConfiguration].serverAddress, self.userInfo.userId, deadlineId];
    [WebUtil webAPICallWithDeleteMethod:urlString];
}

- (void)rejectPushDeadline:(long)deadlineId {
    [self deletePushDeadline:deadlineId];
}

- (void)receivePushDeadline:(Deadline *)deadline {
    [[DeadlineModel getDeadlineModel] addDeadline:deadline];
    
    [self deletePushDeadline:deadline.deadlineId];
    NSString *urlString = [NSString stringWithFormat:@"%@/user/%ld/deadline", [Configuration getConfiguration].serverAddress, self.userInfo.userId];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld", deadline.deadlineId] forKey:@"deadlineId"];
    [WebUtil webAPICallWithPutMethod:urlString parameters:parameters];
}

- (long)addImage:(UIImage *)image {
    CGSize size = CGSizeMake(100, 100);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    image=scaledImage;
    
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1);
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/image", [Configuration getConfiguration].serverAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    NSDictionary *json = [WebUtil webAPICallWithRequest:request];
    long imageId = [[[json objectForKey:@"result"] objectForKey:@"imageId"] longValue];
    return imageId;
}

- (long)addOriginalImage:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1);
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/image", [Configuration getConfiguration].serverAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    NSDictionary *json = [WebUtil webAPICallWithRequest:request];
    long imageId = [[[json objectForKey:@"result"] objectForKey:@"imageId"] longValue];
    return imageId;

}

- (UIImage *)getImage:(long)imageId {
    NSString *urlString = [NSString stringWithFormat:@"%@/image/%ld", [Configuration getConfiguration].serverAddress, imageId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
