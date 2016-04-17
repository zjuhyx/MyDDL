//
//  GroupDetailTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/26/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface GroupDetailTableViewController : UITableViewController

@property (nonatomic) Group *group;

- (instancetype)initWithGroup:(Group *)group;

@end
