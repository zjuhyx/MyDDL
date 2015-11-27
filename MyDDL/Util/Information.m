//
//  Information.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Information.h"

@implementation Information

+ (Information *)getInformation {
    static Information *instance = nil;
    if (instance == nil) {
        instance = [[Information alloc] initPrivate];
    }
    return instance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Can not create a instance of this class" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

@end
