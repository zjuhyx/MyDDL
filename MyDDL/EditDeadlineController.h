//
//  EditDeadlineController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineModificationController2.h"
#import "DeadlineController.h"

@interface EditDeadlineController : DeadlineModificationController2

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController deadline:(Deadline *)deadline;

@end
