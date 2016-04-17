//
//  AddGroupMemberController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/29/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "AddGroupMemberController.h"
#import "Configuration.h"

@interface AddGroupMemberController ()

@property (nonatomic) UITextField *searchField;

@end

@implementation AddGroupMemberController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"添加成员";
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(5, 70, screenSize.width - 10, 35)];
        self.searchField.borderStyle = UITextBorderStyleRoundedRect;
        self.searchField.placeholder = @"输入人员名称";
        [self.view addSubview:self.searchField];
    }
    return self;
}

@end
