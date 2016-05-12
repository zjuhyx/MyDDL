//
//  GroupMessage.m
//  MyDDL
//
//  Created by 柯瀚仰 on 5/12/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import "GroupMessage.h"
#import "Configuration.h"

@implementation GroupMessage

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [self init];
    _content = [json objectForKey:@"content"];
    NSDateFormatter *formatter = [Configuration getConfiguration].formatter;
    _date = [formatter dateFromString:[json objectForKey:@"time"]];
    return self;
}

@end
