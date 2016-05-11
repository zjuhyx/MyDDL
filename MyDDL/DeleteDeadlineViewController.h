//
//  DeleteDeadlineViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/16.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeadlineController.h"

@interface DeleteDeadlineViewController : UITableViewController

@property (nonatomic) DeadlineController* deadlineController;
-(void) toDelete:(int) choice;

@end
