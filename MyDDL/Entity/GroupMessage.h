//
//  GroupMessage.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/12/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMessage : NSObject

@property (nonatomic) NSString *content;
@property (nonatomic) NSDate *date;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
