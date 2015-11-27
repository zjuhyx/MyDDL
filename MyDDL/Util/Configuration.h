//
//  Configuration.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/28/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Configuration : NSObject

@property (nonatomic, readonly) UIColor *themeColor;

+ (Configuration *)getConfiguration;

@end
