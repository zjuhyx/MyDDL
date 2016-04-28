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
        
        _intro_label1=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2, 200, 50)];
        _intro_label1.textAlignment = NSTextAlignmentCenter;
        _intro_label1.font=[UIFont systemFontOfSize:19];
        [self addSubview:_intro_label1];
        
        _intro_label2=[[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2.0-100, 20+radius*2+25, 200, 50)];
        _intro_label2.textAlignment = NSTextAlignmentCenter;
        _intro_label2.font=[UIFont systemFontOfSize:13];
        _intro_label2.textColor=[UIColor grayColor];
        [self addSubview:_intro_label2];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setCellImage:(UIImage *)image imageName:(NSString *)name{
    CGFloat radius = 40.0;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _intro_image_view=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2.0-radius, 20, 80, 80)];
    CALayer *layer = _intro_image_view.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    if(name == nil){
        _intro_image_view.image=image;
    }else{
        _intro_image_view.image=[UIImage imageNamed:name];
    }
    
    
    [self addSubview:_intro_image_view];
}

- (void)setCellLabel1:(NSString *)text1 label2:(NSString *)text2{
    _intro_label1.text=text1;
    _intro_label2.text=text2;
}



@end
