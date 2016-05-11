//
//  DeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineController.h"
#import "DeadlineView.h"
#import "DeadlineModel.h"
#import "Configuration.h"
#import "AxisView.h"
#import "DeadlineDetailController.h"

@interface DeadlineController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

#define EDGE 100

@implementation DeadlineController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background1"]];
        [self loadDeadlineViews];
        [self.view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changeBackground:)]];
        //后面的:一定要有，不然不能跟参数！
    }
    return self;
}

- (void)changeBackground:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan){//防止长按响应两次
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"更换背景图片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"从相册中选取", @"使用相机拍摄",nil];
        actionSheet.tag=2;
        //actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.dataIsChanged) {
        [self loadDeadlineViews];
        self.dataIsChanged = NO;
    }
}

- (void)loadDeadlineViews {
    [self.scrollView removeFromSuperview];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSArray<Deadline *> *deadlines = self.deadlines;
    NSArray<NSNumber *> *distances = [self calculateDistance:deadlines];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat contentHeight = MAX(screenSize.height, 2 * EDGE + (distances.count <= 1 ? 0 : [distances[distances.count - 2] doubleValue]));
    contentHeight = MAX([distances.lastObject doubleValue], contentHeight);
    CGSize contentSize = CGSizeMake(screenSize.width, contentHeight);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    [self.scrollView addSubview:contentView];
    self.scrollView.contentSize = contentSize;
    self.scrollView.contentOffset = CGPointMake(0, contentSize.height - scrollView.frame.size.height + 44 + 48 + 20);
    
    CGFloat redLength = EDGE + [distances.lastObject doubleValue];
    AxisView *axis = [[AxisView alloc] initWithLength:contentSize.height redLength:redLength];
    [contentView addSubview:axis];
    
    UIImageView *timePointLable = [[UIImageView alloc] initWithFrame:CGRectMake(140, contentSize.height - redLength - 7, 40, 20)];
    timePointLable.image = [UIImage imageNamed:@"time_point"];
    [contentView addSubview:timePointLable];
    
    for (int i = 0; i < distances.count - 1; ++i) {
        DeadlineView *deadlineView = [[DeadlineView alloc] initWithOriginY:contentHeight - EDGE - [distances[i] doubleValue] deadline:deadlines[i]];
        deadlineView.viewController = self;
        [contentView addSubview:deadlineView];
    }
}

- (NSArray<Deadline *> *)deadlines {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
    return nil;
}

- (void)enterDeadlineDetail:(Deadline *)deadline {
    [self.navigationController pushViewController:[[DeadlineDetailController alloc] initWithDeadlineController:self deadline:deadline] animated:YES];
}

- (NSArray<NSNumber *> *)calculateDistance:(NSArray<Deadline *> *)deadlines {
    NSMutableArray *distances = [[NSMutableArray alloc] init];
    if (deadlines.count == 0) {
        [distances addObject:[NSNumber numberWithDouble:0]]; // 当前时间
        return distances;
    }
    CGFloat nowDistance = -1; // 把当前时间（即红色DDL标签）也加入到distances数组的计算中
    Deadline *firstDeadline = deadlines[0];
    NSTimeInterval firstDeadlineTimeIntervalSinceNow = [firstDeadline.date timeIntervalSinceNow];
    if (firstDeadlineTimeIntervalSinceNow <= 0) {
        [distances addObject:[NSNumber numberWithDouble:0]];
    } else {
        [distances addObject:[NSNumber numberWithDouble:[self timeIntervalToDistance:firstDeadlineTimeIntervalSinceNow]]];
        nowDistance = 0;
    }
    for (int i = 1; i < deadlines.count; ++i) {
        NSDate *previousDate = deadlines[i - 1].date;
        NSDate *currentDate = deadlines[i].date;
        if ([previousDate timeIntervalSinceNow] <= 0 && [currentDate timeIntervalSinceNow] > 0) {
            nowDistance = [distances[i - 1] doubleValue] + [self timeIntervalToDistance:[[NSDate date] timeIntervalSinceDate:previousDate]] - 30; // DDL标签比较小，所以距离要减去一点
            [distances addObject:[NSNumber numberWithDouble:nowDistance + [self timeIntervalToDistance:[currentDate timeIntervalSinceNow]]]];
        } else {
            [distances addObject:[NSNumber numberWithDouble:[distances[i - 1] doubleValue] + [self timeIntervalToDistance:[currentDate timeIntervalSinceDate:previousDate]]]];
        }
    }
    [distances addObject:[NSNumber numberWithDouble:nowDistance]]; // 把当前时间放在最后
    return distances;
}

- (CGFloat)timeIntervalToDistance:(NSTimeInterval)timeInterval {
    return sqrt(timeInterval / 3600 + 1) * 7 + 53; // 60比一个标签的高度稍微高些
}

@end
