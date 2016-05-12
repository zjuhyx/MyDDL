//
//  GroupSettingViewController.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "XLForm.h"
#import "XLFormViewController.h"
#import "Group.h"

@interface EditGroupViewController : XLFormViewController

@property (nonatomic)NSString* formTitle;
@property (nonatomic)bool isCreate;

@property(nonatomic)Group* group;

//@property (nonatomic)NSString* groupName;
//@property (nonatomic)UIImage* groupImage;
//@property (nonatomic)NSString* groupNickname;
//@property (nonatomic)NSString* groupLeader;

@end
