//
//  DeadlineListViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deadline.h"

@interface DeadlineListViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray<Deadline*>* dataArray;

@end
