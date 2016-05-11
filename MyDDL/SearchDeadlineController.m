//
//  SearchDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "SearchDeadlineController.h"
#import "Configuration.h"
#import "DeadlineCell.h"
#import "DeadlineDetailController.h"

@interface SearchDeadlineController ()

@property (nonatomic) UISearchBar *searchBar;

@end

@implementation SearchDeadlineController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"搜索deadline";
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //searchBar.prompt=@"输入搜索关键词";
    searchBar.placeholder = @"输入搜索关键词";
    
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = searchBar;
    searchBar.delegate=self;//加了这个才能输出搜索框中的数字！！
    
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 就是 UITableViewDataSource
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterData)];
    
    _dataList=[DeadlineModel getDeadlineModel].allDeadlines;
    _showData=[DeadlineModel getDeadlineModel].allDeadlines;
}

/*
 * 如果原 TableView 和 SearchDisplayController 中的 TableView 的 delete 指向同一个对象
 * 需要在回调中区分出当前是哪个 TableView
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_showData count]>0?[_showData count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *cellId = @"mycell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    DeadlineCell *cell=[[DeadlineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    
    Deadline* deadline=[_showData objectAtIndex:indexPath.row];
    
    NSDate *date = [NSDate date];//获取当前时间
    if(deadline.isCompleted==YES){
        if([[deadline.date earlierDate:date] isEqualToDate:date]){
            [cell setDDLStatus:2];//晚于现在的已完成
        }
        else{
            [cell setDDLStatus:4];
        }
    }
    else{
        if([[deadline.date earlierDate:date] isEqualToDate:date]){
            [cell setDDLStatus:1];
        }
        else{
            [cell setDDLStatus:3];
        }
    }
        
    cell.textLabel.text = deadline.name;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式
    cell.detailTextLabel.text = [dateFormat stringFromDate:deadline.date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeadlineDetailController *deadlineDetailController=[[DeadlineDetailController alloc]init];
    deadlineDetailController.deadline=[_showData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:deadlineDetailController animated:YES];
}

//-(void)searchBarSearchButtonClicked:(UISearchBar*) searchBar{
//   
//}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    _showData=[DeadlineModel getDeadlineModel].allDeadlines;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText!=nil && searchText.length>0) {
        _showData= [NSMutableArray array];
        for (int i=0;i<_dataList.count;i++) {
            Deadline* deadline=[_dataList objectAtIndex:i];
            NSString *tempStr=deadline.name;
            if ([tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                [_showData addObject:deadline];
                NSLog(@"%lu",(unsigned long)[_showData count]);
            }
        }
        [self.tableView reloadData];
    }
    else{
        self.showData = [NSMutableArray arrayWithArray:_dataList];
        [self.tableView reloadData];
    }
}

//- (void) filterData{
//    FilterViewController *filterViewController = [[FilterViewController alloc] init];
//    [self presentViewController:filterViewController animated:YES completion:^{//备注2
//        NSLog(@"show InfoView!");
//    }];
//}

@end
