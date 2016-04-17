//
//  DeadlineModificationViewController2.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/13.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "XLForm.h"
#import "XLFormViewController.h"

#import "DeadlineController.h"

@interface DeadlineModificationController2 : XLFormViewController

@property (nonatomic, readonly) NSString *deadlineName;
@property (nonatomic, readonly) NSDate *deadlineDate;
@property (nonatomic, readonly) CourseAndProject *deadlineOwner;
@property (nonatomic, readonly) NSString *deadlineDetail;

@property (nonatomic, weak) UITextField *nameTextField;
@property (nonatomic, weak) UITextView *detailTextView;
@property (nonatomic, weak) UIDatePicker *datePicker;

@property (nonatomic, weak, readonly) DeadlineController *deadlineController;

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController;

- (void)commit;

@end