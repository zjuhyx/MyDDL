//
//  UserDetailViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "UserDetailViewController.h"

#import "IntroCell.h"
#import "ImageDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title=@"个人名片";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0)
        return 1;
    else
        return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 180 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0){
        IntroCell *intro_cell = [[IntroCell alloc] init];
        [intro_cell setCellLabel1:_user.userName label2:[NSString stringWithFormat:@"%ld", _user.userId]];
        [intro_cell setCellImage:_user.userImage imageName:nil];//@"background2"
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [intro_cell.intro_image_view addGestureRecognizer:singleRecognizer];
        [intro_cell.intro_image_view setUserInteractionEnabled:YES];//这句话一定要加！！！
        
        _avater_image=intro_cell.intro_image_view.image;
        
        return intro_cell;
    }
    else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        if(indexPath.row==0){
             cell.imageView.image=[UIImage imageNamed:@"phone"];
            cell.textLabel.text=_user.userPhone;
        }
        else{
            cell.imageView.image=[UIImage imageNamed:@"email"];
            cell.textLabel.text=_user.userEmail;
        }
        return cell;
    }
}

- (void)pickImage{
    ImageDetailViewController *imageDetailViewController = [[ImageDetailViewController alloc] init];
    imageDetailViewController.image=_avater_image;
    [self presentViewController:imageDetailViewController animated:YES completion:^{//备注2
        NSLog(@"showImage!");
    }];
    
}

@end
