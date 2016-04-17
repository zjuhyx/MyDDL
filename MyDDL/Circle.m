//
//  Circle.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "Circle.h"

@implementation Circle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = self.radius;
    [self.color setStroke];
    [path addArcWithCenter:CGPointMake(self.radius, self.radius) radius:self.radius / 2 startAngle:0. endAngle:2 * M_PI clockwise:YES];
    [path stroke];
}

@end
