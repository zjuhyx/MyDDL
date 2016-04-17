//
//  AxisView.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/30/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "AxisView.h"
#import "LineView.h"
#import "Configuration.h"

@implementation AxisView

- (instancetype)initWithLength:(CGFloat)length redLength:(CGFloat)redLength {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    length += 600;
    redLength += 300;
    self = [super initWithFrame:CGRectMake(screenWidth / 2 - AXIS_WIDTH / 2, -300, AXIS_WIDTH, length)];
    if (self) {
        [self addSubview:[[LineView alloc] initWithLength:length color:[UIColor whiteColor] originY:0]];
        [self addSubview:[[LineView alloc] initWithLength:redLength color:[Configuration getConfiguration].redColor originY:length - redLength]];
    }
    return self;
}

@end
