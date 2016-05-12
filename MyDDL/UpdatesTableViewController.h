//
//  UpdatesTableViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupMessage.h"

@interface UpdatesTableViewController : UITableViewController

@property(nonatomic)long groupId;
@property(nonatomic)NSArray<GroupMessage *> *messages;

@end
