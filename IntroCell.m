//
//  IntroCell.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "IntroCell.h"

@implementation IntroCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat radius = 40.0;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        intro_label1=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2, 200, 50)];
        intro_label1.textAlignment = NSTextAlignmentCenter;
        intro_label1.font=[UIFont systemFontOfSize:19];
        [self addSubview:intro_label1];
        
        intro_label2=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2+25, 200, 50)];
        intro_label2.textAlignment = NSTextAlignmentCenter;
        intro_label2.font=[UIFont systemFontOfSize:13];
        intro_label2.textColor=[UIColor grayColor];
        [self addSubview:intro_label2];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setCellImage:(UIImage *)image imageName:(NSString *)name{
    CGFloat radius = 40.0;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    intro_image_view=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0-radius, 20, 80, 80)];
    CALayer *layer = intro_image_view.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    if(name == nil){
        intro_image_view.image=image;
    }else{
        intro_image_view.image=[UIImage imageNamed:name];
    }
    [intro_image_view addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage:)]];
    
    [self addSubview:intro_image_view];
}

- (void)setCellLabel1:(NSString *)text1 label2:(NSString *)text2{
    intro_label1.text=text1;
    intro_label2.text=text2;
}

- (void)pickImage:(UIImageView *)imageView{
    //用modal做
}

@end
