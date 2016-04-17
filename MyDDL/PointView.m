//
//  PointView.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "PointView.h"
#import "Circle.h"
#import "Configuration.h"

@implementation PointView

- (instancetype)initWithCenter:(CGPoint)center innerColor:(UIColor *)innerColor outerColor:(UIColor *)outerColor {
    self = [super initWithFrame:CGRectMake(center.x, center.y, 20, 20)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        Circle *innerCircle = [[Circle alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        innerCircle.color = innerColor;
        innerCircle.radius = 5;
        Circle *outerCircle = [[Circle alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        outerCircle.color = outerColor;
        outerCircle.radius = 10;
        [self addSubview:outerCircle];
        [self addSubview:innerCircle];
    }
    return self;
}
@end
