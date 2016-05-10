//
//  CourseAndProject.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseAndProject : NSObject

@property (nonatomic) long courseProjectId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *detail;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithJSON:(NSDictionary *)json;

@end
