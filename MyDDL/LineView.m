//
//  RedAxisView.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (instancetype)initWithLength:(CGFloat)length color:(UIColor *)color originY:(CGFloat)y {
    self = [super initWithFrame:CGRectMake(0, y, AXIS_WIDTH, length)];
    if (self) {
        self.backgroundColor = color;
    }
    return self;
}

@end
