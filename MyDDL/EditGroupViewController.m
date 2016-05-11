//
//  GroupSettingViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/28.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "EditGroupViewController.h"

@interface EditGroupViewController() <XLFormDescriptorDelegate>

@end

@implementation EditGroupViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        form.assignFirstResponderOnShow = YES;
        form = [XLFormDescriptor formDescriptorWithTitle:_formTitle];//???
        
        //section1
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        //群名
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText];
        row.title=@"群名称";
        if(_isCreate==NO){
            row.value=@"hehe";
        }
        else
            [row.cellConfigAtConfigure setObject:@"输入群名称" forKey:@"textField.placeholder"];
        
        [section addFormRow:row];
        //群头像
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kImage" rowType:XLFormRowDescriptorTypeImage title:@"群头像"];
        if(_isCreate)
            row.value = [UIImage imageNamed:@"pickImage_default"];
        else{
            row.value = [UIImage imageNamed:@"pickImage_default"];
        }
        [section addFormRow:row];
        
        if(_isCreate==NO){
            section = [XLFormSectionDescriptor formSection];
            [form addFormSection:section];
            //群名片
            row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeText];
            row.title=@"群名片";
            row.value=@"heheda";
            [section addFormRow:row];
            
            section = [XLFormSectionDescriptor formSection];
            [form addFormSection:section];
            //转让群
            // Selector Push
            row = [XLFormRowDescriptor formRowDescriptorWithTag:@"push" rowType:XLFormRowDescriptorTypeSelectorPush title:@"群主"];
            row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                                    ];
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"];
            [section addFormRow:row];
        }
        
        self.form=form;//前面加了self = [super init];就可以用这一句了！！
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toSave)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toCancel)];
}

-(void)toCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) toSave{
    //...保存编辑内容
    [self.navigationController popViewControllerAnimated:YES];
}

@end
