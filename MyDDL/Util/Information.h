//
//  Information.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject

@property (nonatomic) NSString *username;

+ (Information *)getInformation;

@end