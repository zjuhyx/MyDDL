//
//  CourseAndProjectDetailTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/27/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseAndProject.h"

@interface CourseAndProjectDetailTableViewController : UITableViewController

//@property (nonatomic, readonly) NSString *itemImageName;
@property (nonatomic, readonly) NSString *itemDetail;
@property (nonatomic, readonly) NSString *deleteItem;

@property(nonatomic) UIColor *blueColor;

- (void)editItem;

@property(nonatomic)CourseAndProject* courseAndProject;

@end
