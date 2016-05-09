//
//  GroupModel.h
//  MyDDL
//
//  Created by 柯瀚仰 on 5/9/16.
//  Copyright © 2016 柯瀚仰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic) NSMutableArray *groups;

+ (instancetype)getInstance;

@end
