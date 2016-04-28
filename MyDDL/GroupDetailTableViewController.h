//
//  GroupDetailTableViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@interface GroupDetailTableViewController : UITableViewController

@property (nonatomic) Group *group;
@property (nonatomic) UIImage *avater_image;

- (instancetype)initWithGroup:(Group *)group;

@end