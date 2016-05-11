//
//  UserInfo.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/8/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic) long userId;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userImage;
@property (nonatomic) NSString *userPhone;
@property (nonatomic) NSString *userEmail;
@property (nonatomic) int mainScreenImage;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
