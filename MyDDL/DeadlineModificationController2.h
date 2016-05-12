//
//  DeadlineModificationViewController2.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/13.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//
#import "DeadlineController.h"

#import "XLForm.h"
#import "XLFormViewController.h"

@interface DeadlineModificationController2 : XLFormViewController

@property (nonatomic) Deadline *deadline;
@property (nonatomic, weak, readonly) DeadlineController *deadlineController;
@property (nonatomic)UIImage* defaultImage;

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController;
- (void)afterInit;

- (void)commit;

@end