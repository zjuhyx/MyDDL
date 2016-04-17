//
//  JoinGroupController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/29/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "JoinGroupController.h"
#import "Configuration.h"

@interface JoinGroupController ()

@property (nonatomic) UISearchBar *searchBar;

@end

@implementation JoinGroupController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"加入小组";
        self.view.frame = [UIScreen mainScreen].bounds;
        self.view.backgroundColor = [Configuration getConfiguration].grayColor;
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 70, screenSize.width - 10, 35)];
        UISearchBar *searchBar = self.searchBar;
        searchBar.barStyle = UIBarStyleDefault;
        searchBar.placeholder = @"输入名称来进行搜索";
        
        [self.view addSubview:self.searchBar];
    }
    return self;
}

@end
