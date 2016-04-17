//
//  DeadlineDetailController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeadlineController.h"

@interface DeadlineDetailController : UITableViewController

@property (nonatomic) Deadline *deadline;
@property (nonatomic) UIColor *blueColor;
@property (nonatomic) UISwitch *switchview;

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController deadline:(Deadline *)deadline;

@end
