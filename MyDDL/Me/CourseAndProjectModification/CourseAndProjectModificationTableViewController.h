//
//  CourseAndProjectModificationTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseAndProjectModificationTableViewController : UITableViewController

@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *itemImageName;
@property (nonatomic) NSString *itemDetail;

- (void)commit;

@end
