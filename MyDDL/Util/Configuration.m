//
//  Configuration.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

+ (Configuration *)getConfiguration {
    static Configuration *instance = nil;
    if (instance == nil) {
        instance = [[Configuration alloc] initPrivate];
    }
    return instance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _themeColor = [UIColor colorWithRed:40./255 green:40./255 blue:40./255 alpha:1.0];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Can not create a instance of this class" userInfo:nil];
    return nil;
}

@end
