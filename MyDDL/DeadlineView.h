//
//  DeadlineController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/30/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeadlineController.h"
#import "Deadline.h"

@interface DeadlineView : UIView

@property (nonatomic, weak) DeadlineController *viewController;
@property (nonatomic, readonly) BOOL isUrgent;
@property (nonatomic, readonly) BOOL isCompleted;

@property (nonatomic) Deadline *deadline;

- (instancetype)initWithOriginY:(CGFloat)y deadline:(Deadline *)deadline;
//这边instancetype是什么意思？这个是自定义的函数吗？

@end
