//
//  SearchDeadlineController.m
//  MyDDL
//
//  Created by 柯瀚仰 on 12/1/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "SearchDeadlineController.h"
#import "Configuration.h"

@interface SearchDeadlineController ()

@property (nonatomic) UISearchBar *searchBar;

@end

@implementation SearchDeadlineController

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.navigationItem.title = @"搜索deadline";
//        self.view.frame = [UIScreen mainScreen].bounds;
//        self.view.backgroundColor = [Configuration getConfiguration].grayColor;
//        
//        CGSize screenSize = [UIScreen mainScreen].bounds.size;
//        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 70, screenSize.width - 10, 35)];
//        UISearchBar *searchBar = self.searchBar;
//        searchBar.barStyle = UIBarStyleDefault;
//        searchBar.placeholder = @"输入关键词来进行搜索";
//        
//        [self.view addSubview:self.searchBar];
//    }
//    return self;
//}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"搜索deadline";
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width
                                                                        , 44)];
    //searchBar.prompt=@"输入搜索关键词";
    searchBar.placeholder = @"输入搜索关键词";
    
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = searchBar;
    
    // 用 searchbar 初始化 SearchDisplayController
    // 并把 searchDisplayController 和当前 controller 关联起来
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 就是 UITableViewDataSource
    searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    searchDisplayController.searchResultsDelegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterData)];
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width
//                                                                           , 44)];
//    //searchBar.prompt=@"输入搜索关键词";
//    searchBar.placeholder = @"输入搜索关键词";
//    
//    // 添加 searchbar 到 headerview
//    UIView *headerView = searchBar;
//    
//    // 用 searchbar 初始化 SearchDisplayController
//    // 并把 searchDisplayController 和当前 controller 关联起来
//    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    
//    // searchResultsDataSource 就是 UITableViewDataSource
//    searchDisplayController.searchResultsDataSource = self;
//    // searchResultsDelegate 就是 UITableViewDelegate
//    searchDisplayController.searchResultsDelegate = self;
//    
//    return headerView;
//}

/*
 * 如果原 TableView 和 SearchDisplayController 中的 TableView 的 delete 指向同一个对象
 * 需要在回调中区分出当前是哪个 TableView
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return data.count;
    }else{
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[data filteredArrayUsingPredicate:predicate]];
        return filterData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (tableView == self.tableView) {
        cell.textLabel.text = data[indexPath.row];
    }else{
        cell.textLabel.text = filterData[indexPath.row];
    }
    
    return cell;
}

//UISearchBar有个代理方法
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//每次文字变化的时候就会调用
//在这里处理数据然后重载UITableView就可以了

- (void) filterData{
    FilterViewController *filterViewController = [[FilterViewController alloc] init];
    [self presentViewController:filterViewController animated:YES completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
}

@end
