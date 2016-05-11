//
//  GroupTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface GroupTableViewController : UITableViewController

@property(nonatomic)NSArray<Group*>* groups;
@property(nonatomic)bool isShare;

@end
