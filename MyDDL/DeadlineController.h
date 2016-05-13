//
//  DeadlineController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deadline.h"

@interface DeadlineController : UIViewController

@property (nonatomic, readonly) NSArray<Deadline *> *deadlines;
@property (nonatomic) BOOL dataIsChanged;

- (void)enterDeadlineDetail:(Deadline *)deadline;
- (void)loadDeadlineViews;

@end
