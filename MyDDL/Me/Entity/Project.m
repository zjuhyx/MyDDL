//
//  Project.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Project.h"

@implementation Project

- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *result = [super toDictionary];
    [result setValue:@"project" forKey:@"courseProjectType"];
    return result;
}

@end
