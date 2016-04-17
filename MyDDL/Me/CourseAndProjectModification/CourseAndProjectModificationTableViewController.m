//
//  CourseAndProjectModificationTableViewController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "CourseAndProjectModificationTableViewController.h"
#import "Configuration.h"

@implementation CourseAndProjectModificationTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commit)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 60. : 120.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"UITableViewCell"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (indexPath.section == 0) {
        UITextField *itemNameTextField =
            [[UITextField alloc] initWithFrame:CGRectMake(80, 0, screenSize.width - 80, 60)];
        itemNameTextField.placeholder = self.itemName;
        [cell.contentView addSubview:itemNameTextField];
        cell.imageView.image = [UIImage imageNamed:self.itemImageName];
        CALayer *layer = cell.imageView.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 25.0;
    } else {
        UITextView *itemDetailTextView =
            [[UITextView alloc] initWithFrame:CGRectMake(15, 0, screenSize.width - 30, 120.)];
        itemDetailTextView.text = self.itemDetail;
        [cell.contentView addSubview:itemDetailTextView];
    }
    return cell;
}

- (void)commit {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
