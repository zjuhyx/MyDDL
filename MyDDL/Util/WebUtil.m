//
//  WebUtil.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "WebUtil.h"

@implementation WebUtil

+ (NSDictionary *)webAPICallWithRequest:(NSURLRequest *)request {
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return jsonObject;
}

@end
