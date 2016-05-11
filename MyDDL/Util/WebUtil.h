//
//  WebUtil.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebUtil : NSObject

+ (NSDictionary *)webAPICallWithRequest:(NSURLRequest *)request;
+ (NSDictionary *)webAPICallWithGetMethod:(NSString *)urlString;

@end
