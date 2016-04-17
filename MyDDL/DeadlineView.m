//
//  DeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 11/30/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineView.h"
#import "Configuration.h"
#import "PointView.h"
#import "DeadlineDetailController.h"
#import "Course.h"
#import "Project.h"

@interface DeadlineView ()

@property (nonatomic, weak) UIImageView *backgroundLabel;
@property (nonatomic, weak) UILabel *deadlineTitle;
@property (nonatomic, weak) UILabel *deadlineTime;

@end

@implementation DeadlineView

- (instancetype)initWithOriginY:(CGFloat)y deadline:(Deadline *)deadline {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(screenWidth / 2 -20, y, screenWidth / 2, 55);
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backgroundLabel = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, frame.size.width - 35, frame.size.height)];
        self.backgroundLabel = backgroundLabel;
        backgroundLabel.image = [UIImage imageNamed:@"deadline_label"];
        UILabel *deadlineTitle = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, frame.size.width - 55, 20)];
        self.deadlineTitle = deadlineTitle;
        deadlineTitle.font = [UIFont systemFontOfSize:12];
        UILabel *deadlineTime = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, frame.size.width - 55, 20)];
        self.deadlineTime = deadlineTime;
        deadlineTime.font = [UIFont systemFontOfSize:12];
        [self addSubview:backgroundLabel];
        [self addSubview:deadlineTitle];
        [self addSubview:deadlineTime];
        
        self.deadline = deadline;
        
        Configuration *config = [Configuration getConfiguration];
        UIColor *pointInnerColor;
        if ([deadline.owner isKindOfClass:[Course class]]) {
            pointInnerColor = config.blueColor;
        } else {
            pointInnerColor = config.greenColor;
        }
        UIColor *pointOuterColor;
        if ([deadline.date timeIntervalSinceNow] <= 0) {
            pointOuterColor = config.redColor;
        } else {
            pointOuterColor = [UIColor whiteColor];
        }
        [self addSubview:[[PointView alloc] initWithCenter:CGPointMake(0, 0) innerColor:pointInnerColor outerColor:pointOuterColor]];
    }
    return self;
}

- (void)setDeadline:(Deadline *)deadline {
    _deadline = deadline;
    self.deadlineTitle.text = deadline.name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.deadlineTime.text = [formatter stringFromDate:deadline.date];
    if (deadline.isCompleted) {
        self.isCompleted = YES;
    }
    if ([deadline.date timeIntervalSinceNow] <= 3600 * 24) {//24h之内的ddl为紧急ddl
        self.isUrgent = YES;
    }
}

- (void)setIsUrgent:(BOOL)isUrgent {
    _isUrgent = isUrgent;
    [self updateBackgroundImage];
}

- (void)setIsCompleted:(BOOL)isCompleted {
    _isCompleted = isCompleted;
    [self updateBackgroundImage];
}

- (void)updateBackgroundImage {
    if (self.isCompleted) {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label_completed"];
    } else if ([self.deadline.date timeIntervalSinceNow] <= 0) {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label_red"];
    } else if (self.isUrgent) {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label_urgent"];
    } else {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.deadline.owner isKindOfClass:[Course class]]) {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label_blue"];
    } else {
        self.backgroundLabel.image = [UIImage imageNamed:@"deadline_label_green"];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.viewController enterDeadlineDetail:self.deadline];
    [self updateBackgroundImage];
}

@end
