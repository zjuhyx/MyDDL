//
//  DoneTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineController.h"

@interface DoneViewController : DeadlineController{
    NSString* filePath;
}

+ (DoneViewController *)setAndGetInstance:(DoneViewController *)doneViewController;

@end
