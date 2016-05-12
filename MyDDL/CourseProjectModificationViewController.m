//
//  CourseProjectModificationViewController.m
//  MyDDL
//
//  Created by 胡譯心 on 16/4/19.
//  Copyright © 2016年 柯瀚仰. All rights reserved.
//

#import "CourseProjectModificationViewController.h"
//#import "Configuration.h"
#import "CourseProjectModel.h"
#import "CourseDetailTableViewController.h"
#import "ProjectDetailTableViewController.h"

@interface CourseProjectModificationViewController() <XLFormDescriptorDelegate>

@end

@implementation CourseProjectModificationViewController

- (instancetype)init {
    if (self) {
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        form.assignFirstResponderOnShow = YES;
        form = [XLFormDescriptor formDescriptorWithTitle:@"编辑"];//???
        
        //section1
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        // 标题
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText];
        [row.cellConfig setObject:[UIFont systemFontOfSize:20] forKey:@"textField.font"];
        [row.cellConfigAtConfigure setObject:@"标题" forKey:@"textField.placeholder"];
        if(_isCreate==NO)
            row.value=_courseAndProject.name;
        [section addFormRow:row];
        
//        //section2
//        section = [XLFormSectionDescriptor formSectionWithTitle:@"联系信息"];
//        //section.footerTitle = @"This is a long text that will appear on section footer";
//        [form addFormSection:section];
//        //联系人
//        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"teacher" rowType:XLFormRowDescriptorTypeText title:@"联系人"];
//        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
//        [section addFormRow:row];
//        //联系方式-手机
//        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"integer" rowType:XLFormRowDescriptorTypeInteger title:@"联系电话"];
//        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
//        [section addFormRow:row];
//        // Email
//        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"email" rowType:XLFormRowDescriptorTypeEmail title:@"邮箱"];
//        [row.cellConfigAtConfigure setObject:@"（选填）" forKey:@"textField.placeholder"];
//        // validate the email
//        [row addValidator:[XLFormValidator emailValidator]];
//        [section addFormRow:row];
        
        //section3
        section = [XLFormSectionDescriptor formSectionWithTitle:@"详情"];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"note" rowType:XLFormRowDescriptorTypeTextView];
        [row.cellConfigAtConfigure setObject:@"添加注释" forKey:@"textView.placeholder"];
        if(_isCreate==NO)
            row.value=_courseAndProject.detail;
        [section addFormRow:row];
        
        //self.form = form;//用这一句 表格样式会变掉。。。
        self=[super initWithForm:form];
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // change cell height of a particular cell
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"title"]){
        return 60.0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(commit)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

- (void)commit {
    //改服务端
    if(_isCreate==YES){
        if([_formTitle isEqualToString:@"课程"]){
            _courseAndProject=[Course alloc];
        }
        else{
            _courseAndProject=[Project alloc];
        }
        _courseAndProject.name=[self.form formRowWithTag:@"title"].value;
        _courseAndProject.detail=[self.form formRowWithTag:@"note"].value;
        [[CourseProjectModel getInstance] addCourseProject:_courseAndProject];
    }
    else{
        _courseAndProject.name=[self.form formRowWithTag:@"title"].value;
        _courseAndProject.detail=[self.form formRowWithTag:@"note"].value;
        [[CourseProjectModel getInstance] changeCourseProject:_courseAndProject];
        
        if([_formTitle isEqualToString:@"课程"]){
            CourseDetailTableViewController *courseDetailTableViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1];
            courseDetailTableViewController.courseAndProject = _courseAndProject;
            [self.navigationController popToViewController:courseDetailTableViewController animated:true];
        }
        else{
            ProjectDetailTableViewController *projectDetailTableViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1];
            projectDetailTableViewController.courseAndProject = _courseAndProject;
            [self.navigationController popToViewController:projectDetailTableViewController animated:true];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    //@throw [NSException exceptionWithName:@"Uncallable method" reason:@"Please call the subclass' method" userInfo:nil];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
