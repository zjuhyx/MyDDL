//
//  CourseAndProjectTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseAndProject.h"
#import "CourseAndProjectDetailTableViewController.h"

@interface CourseAndProjectTableViewController : UITableViewController

@property (nonatomic, readonly) CourseAndProjectDetailTableViewController *nextViewController;
@property(nonatomic)NSArray<CourseAndProject*>* data;
@property(nonatomic)CourseAndProject* courseAndProject;

//- (UIImage *)cellImageAtIndexPath:(NSIndexPath *)indexPath;
- (void)addNewItem;

@end
