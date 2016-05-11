//
//  SearchDeadlineController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"
#import "DeadlineModel.h"

@interface SearchDeadlineController : UITableViewController{
    NSArray *data;
    NSArray *filterData;
    UISearchDisplayController *searchDisplayController;
}

@property(nonatomic)NSArray *dataList;
@property(nonatomic)NSMutableArray *showData;
@property(nonatomic,retain)FilterViewController *filterViewController;
@end
