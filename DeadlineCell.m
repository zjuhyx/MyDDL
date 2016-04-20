//
//  DeadlineCell.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/20.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "DeadlineCell.h"

@implementation DeadlineCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setDDLStatus:(int)status{
    if(status==1){//未过ddl，未完成 ffd201
        self.imageView.image=[UIImage imageNamed:@"point_yellow"];
    }
    else if(status==2){//未过ddl，已完成 2eda21
        self.imageView.image=[UIImage imageNamed:@"point_green"];
    }
    else if(status==3){//过ddl，未完成
        self.imageView.image=[UIImage imageNamed:@"point_red"];
    }
    else if(status==4){//过ddl，已完成 848484
        self.imageView.image=[UIImage imageNamed:@"point_gray"];
    }
    
}

- (void)setDDLTitle:(NSString *)title date:(NSString *)date{
    self.textLabel.text=title;
    self.detailTextLabel.text=date;
}

@end
