//
//  AddProjectController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "AddProjectController.h"

@implementation AddProjectController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"添加项目";
    }
    return self;
}

- (NSString *)itemName {
    return @"项目名称";
}

- (NSString *)itemImageName {
    return @"project_default";
}

- (NSString *)itemDetail {
    return @"项目备注";
}

- (void)commit {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
