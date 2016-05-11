//
//  UserDetailViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface UserDetailViewController : UITableViewController

@property(nonatomic)UIImage* avater_image;
@property(nonatomic)Person* user;

@end
