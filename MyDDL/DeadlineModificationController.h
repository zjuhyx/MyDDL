//
//  DeadlineModificationController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeadlineController.h"

@interface DeadlineModificationController : UITableViewController

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
