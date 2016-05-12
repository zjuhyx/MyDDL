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

+ (NSDictionary *)webAPICallWithGetMethod:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    return [WebUtil webAPICallWithRequest:request];
}

+ (NSDictionary *)webAPICallWithDeleteMethod:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    request.HTTPMethod = @"DELETE";
    return [WebUtil webAPICallWithRequest:request];
}

+ (NSString *)convertDictionary:(NSDictionary *)parameters {
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *key in parameters.allKeys) {
        if (result.length > 0) {
            [result appendString:@"&"];
        }
        [result appendString:key];
        [result appendString:@"="];
        [result appendString:[parameters objectForKey:key]];
    }
    return result;
}

+ (NSDictionary *)webAPICallWithPostMethod:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    NSString *post = [WebUtil convertDictionary:parameters];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    return [WebUtil webAPICallWithRequest:request];
}

+ (NSDictionary *)webAPICallWithPutMethod:(NSString *)urlString parameters:(NSDictionary *)parameters {
    NSString *wholeURL = [NSString stringWithFormat:@"%@?%@", urlString, [WebUtil convertDictionary:parameters]];
    NSURL *url = [NSURL URLWithString:wholeURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    request.HTTPMethod = @"PUT";
    NSLog(@"%@", wholeURL);
    NSDictionary *addResult = [[WebUtil webAPICallWithRequest:request] objectForKey:@"result"];
    return addResult;
}

@end
