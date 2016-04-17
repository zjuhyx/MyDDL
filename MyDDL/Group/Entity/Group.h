//
//  Group.h
//  MyDDL
//
//  Created by 柯瀚仰 on 12/4/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deadline.h"
#import "Person.h"

@interface Group : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) UIImage *avatar;
@property (nonatomic) Deadline *deadline;
@property (nonatomic) NSArray<Person *> *members;

- (instancetype)initWithName:(NSString *)name deadline:(Deadline *)deadline;

@end
