//
//  RedAxisView.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AXIS_WIDTH 2

@interface LineView : UIView

- (instancetype)initWithLength:(CGFloat)length color:(UIColor *)color originY:(CGFloat)y;

@end
