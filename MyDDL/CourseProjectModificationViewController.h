//
//  CourseProjectModificationViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/19.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "XLForm.h"
#import "XLFormViewController.h"
#import "CourseAndProject.h"

@interface CourseProjectModificationViewController : XLFormViewController

@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *itemImageName;
@property (nonatomic) NSString *itemDetail;

@property(nonatomic)CourseAndProject* courseAndProject;
@property(nonatomic)bool isCreate;
@property(nonatomic)NSString* formTitle;

- (void)commit;

@end
