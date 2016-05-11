//
//  DeadlineModificationViewController2.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/13.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "DeadlineModificationController2.h"

NSString *const kDateInline = @"dateInline";
NSString *const kTimeInline = @"timeInline";
NSString *const kDateTimeInline = @"dateTimeInline";
NSString *const kCountDownTimerInline = @"countDownTimerInline";
NSString *const kDatePicker = @"datePicker";
NSString *const kDate = @"date";
NSString *const kTime = @"time";
NSString *const kDateTime = @"dateTime";
NSString *const kCountDownTimer = @"countDownTimer";

@interface DeadlineModificationController2() <XLFormDescriptorDelegate>

@end

@implementation DeadlineModificationController2

- (instancetype)init {
    @throw [NSException exceptionWithName:@"unallowed initial method" reason:@"You should use initWithDeadlineController" userInfo:nil];
    return nil;
}

- (instancetype)initWithDeadlineController:(DeadlineController *)deadlineController {
    self = [super init];
    if (self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commit)];
        _deadlineController = deadlineController;
        
        
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        form.assignFirstResponderOnShow = YES;
        form = [XLFormDescriptor formDescriptorWithTitle:@"编辑"];
        
        //section1
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        // 标题
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText];
        [row.cellConfig setObject:[UIFont systemFontOfSize:20] forKey:@"textField.font"];
        [row.cellConfigAtConfigure setObject:@"标题" forKey:@"textField.placeholder"];
        row.value=_deadline.name;
        
        [section addFormRow:row];
        
        /////////////
        // Selector Left Right
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kSelectorLeftRight" rowType:XLFormRowDescriptorTypeSelectorLeftRight title:@"Left Right"];
        row.leftRightSelectorLeftOptionSelected = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"课程"];
        
        NSArray * rightOptions =  @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Right Option 1"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Right Option 2"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Right Option 3"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Right Option 4"],
                                    [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Right Option 5"]
                                    ];
        // create right selectors
        NSMutableArray * leftRightSelectorOptions = [[NSMutableArray alloc] init];
        NSMutableArray * mutableRightOptions = [rightOptions mutableCopy];
        [mutableRightOptions removeObjectAtIndex:0];
        XLFormLeftRightSelectorOption * leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"课程"] httpParameterKey:@"option_1" rightOptions:mutableRightOptions];
        [leftRightSelectorOptions addObject:leftRightSelectorOption];
        
        mutableRightOptions = [rightOptions mutableCopy];
        [mutableRightOptions removeObjectAtIndex:1];
        leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"科研"] httpParameterKey:@"option_2" rightOptions:mutableRightOptions];
        [leftRightSelectorOptions addObject:leftRightSelectorOption];
        
        row.selectorOptions  = leftRightSelectorOptions;
        row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Right Option 4"];
        [section addFormRow:row];
        /////////////
        
        // 日期
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateInline rowType:XLFormRowDescriptorTypeDateInline title:@"Deadline日期"];
        row.value = [NSDate new];
        [section addFormRow:row];
        // 时间
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTimeInline rowType:XLFormRowDescriptorTypeTimeInline title:@"Deadline时间"];
        row.value = [NSDate new];
        [section addFormRow:row];
        
        //section2
        section = [XLFormSectionDescriptor formSectionWithTitle:@"联系信息"];
        //section.footerTitle = @"This is a long text that will appear on section footer";
        [form addFormSection:section];
        //联系人
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"teacher" rowType:XLFormRowDescriptorTypeText title:@"联系人"];
        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
        
        [section addFormRow:row];
        //联系方式-手机
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"integer" rowType:XLFormRowDescriptorTypeInteger title:@"联系电话"];
        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
        [section addFormRow:row];
        // Email
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeEmail title:@"邮箱"];
        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
        // validate the email
        [row addValidator:[XLFormValidator emailValidator]];
        [section addFormRow:row];
        
        //section3
        section = [XLFormSectionDescriptor formSectionWithTitle:@"详情"];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"note" rowType:XLFormRowDescriptorTypeTextView];
        [row.cellConfigAtConfigure setObject:@"添加注释" forKey:@"textView.placeholder"];
        [section addFormRow:row];

        // Selector Push
//        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kSelectorMap" rowType:XLFormRowDescriptorTypeSelectorPush title:@"添加图片"];
//        [section addFormRow:row];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kImage" rowType:XLFormRowDescriptorTypeImage title:@"添加图片"];
        row.value = [UIImage imageNamed:@"pickImage_default"];
        [section addFormRow:row];
        
        
        self.form = form;
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithTitle:@"Disable" style:UIBarButtonItemStylePlain target:self action:@selector(disableEnable:)];
    //barButton.possibleTitles = [NSSet setWithObjects:@"Disable", @"Enable", nil];
    //self.navigationItem.rightBarButtonItem = barButton;
}

-(void)disableEnable:(UIBarButtonItem *)button
{
    self.form.disabled = !self.form.disabled;
    [button setTitle:(self.form.disabled ? @"Enable" : @"Disable")];
    [self.tableView endEditing:YES];
    [self.tableView reloadData];
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
    //...
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // change cell height of a particular cell
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"title"]){
        return 60.0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    // super implementation must be called
    [super formRowDescriptorValueHasChanged:formRow oldValue:oldValue newValue:newValue];
    
    
    if([formRow.tag isEqualToString:kDatePicker])
    {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"DatePicker"
                                                          message:@"Value Has changed!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
#else
        if ([UIAlertController class]) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"DatePicker"
                                                                                      message:@"Value Has changed!"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"DatePicker"
                                                              message:@"Value Has changed!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
#endif
    }
}

- (void)commit {
    @throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

@end