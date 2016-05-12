//
//  DeadlineModificationViewController2.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/13.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "DeadlineModificationController2.h"
#import "Model.h"
#import "Course.h"
#import "Project.h"

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
        _deadlineController = deadlineController;
    }
    return self;
}

- (void)afterInit {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commit)];
    
    
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
    if ([_deadline.courseProjectType isEqualToString:@"course"]) {
        row.leftRightSelectorLeftOptionSelected = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"课程"];
    }
    else{
        row.leftRightSelectorLeftOptionSelected = [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"项目"];
    }
    
    // create right selectors
    NSMutableArray * leftRightSelectorOptions = [[NSMutableArray alloc] init];
    
    NSMutableArray* courseOptions = [Model getInstance].courseProjectModel.courses;
    //[mutableRightOptions1 removeObjectAtIndex:0];
    NSMutableArray* courseNames=[[NSMutableArray alloc] init];
    for(int i=0;i<courseOptions.count;i++){
        Course* course=[courseOptions objectAtIndex:i];
        [courseNames addObject:course.name];
    }
    XLFormLeftRightSelectorOption * leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"课程"] httpParameterKey:@"option_1" rightOptions:courseNames];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    NSMutableArray* projectOptions = [Model getInstance].courseProjectModel.projects;
    NSMutableArray* projectNames=[[NSMutableArray alloc] init];
    for(int i=0;i<projectOptions.count;i++){
        Project* project=[projectOptions objectAtIndex:i];
        [projectNames addObject:project.name];
    }
    //[mutableRightOptions removeObjectAtIndex:1];
    leftRightSelectorOption = [XLFormLeftRightSelectorOption formLeftRightSelectorOptionWithLeftValue:[XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"项目"] httpParameterKey:@"option_2" rightOptions:projectNames];
    [leftRightSelectorOptions addObject:leftRightSelectorOption];
    
    row.selectorOptions  = leftRightSelectorOptions;
    //row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:_deadline.courseProjectName];
    row.value=_deadline.courseProjectName;
    //row.title=_deadline.courseProjectType;
    NSLog(_deadline.courseProjectType);
    
    [section addFormRow:row];
    /////////////
    
    // 日期
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"date" rowType:XLFormRowDescriptorTypeDateInline title:@"Deadline日期"];
    row.value = _deadline.date;
    [section addFormRow:row];
    // 时间
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"time" rowType:XLFormRowDescriptorTypeTimeInline title:@"Deadline时间"];
    row.value = _deadline.date;
    [section addFormRow:row];
    
    //section2
    section = [XLFormSectionDescriptor formSectionWithTitle:@"联系信息"];
    //section.footerTitle = @"This is a long text that will appear on section footer";
    [form addFormSection:section];
    //联系人
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"contact" rowType:XLFormRowDescriptorTypeText title:@"联系人"];
    [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
    row.value=_deadline.contactName;
    [section addFormRow:row];
    //联系方式-手机
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"phone" rowType:XLFormRowDescriptorTypeInteger title:@"联系电话"];
    [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
    row.value=_deadline.contactPhone;
    [section addFormRow:row];
    // Email
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeText title:@"邮箱"];
    [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
    row.value=_deadline.contactEmail;
    // validate the email
    //[row addValidator:[XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    //section3
    section = [XLFormSectionDescriptor formSectionWithTitle:@"详情"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"detail" rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"添加注释" forKey:@"textView.placeholder"];
    [section addFormRow:row];
    
    // Selector Push
    //        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"kSelectorMap" rowType:XLFormRowDescriptorTypeSelectorPush title:@"添加图片"];
    //        [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"image" rowType:XLFormRowDescriptorTypeImage title:@"添加图片"];
    row.value = [UIImage imageNamed:@"pickImage_default"];
    
    [section addFormRow:row];
    
    
    self.form = form;
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