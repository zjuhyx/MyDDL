//
//  IntroCell.h
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroCell : UITableViewCell{
    UIImageView *intro_image_view;
    UILabel *intro_label1;
    UILabel *intro_label2;
}

- (void)setCellImage:(UIImage *)image imageName:(NSString *)name;
- (void)setCellLabel1:(NSString *)text1 label2:(NSString *)text2;

@end
