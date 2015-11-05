//
//  SZHomeViewController.m
//  实战1
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "SZHomeViewController.h"
#import "SZOneViewController.h"
#import "SZHomeOneViewController.h"

#import "UIBarButtonItem+SZItem.h"
#import "SZTitleButton.h"


#import "SZCover.h"
#import "UIView+Frame.h"
#import "SZPopMenu.h"
#import "SZAccountTool.h"

#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetworking.h"


@interface SZHomeViewController ()<SZCoverDelegate>

@property (nonatomic, strong) SZOneViewController *one;
@property (nonatomic, weak) SZTitleButton *titleButton;
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation SZHomeViewController

-(NSMutableArray *)statuses{
    
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    
    return _statuses;
}

-(SZOneViewController *)one{
    
    if (_one ==nil) {
        _one = [[SZOneViewController alloc] init];
        
    }
    return _one;
}
// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    [super viewDidLoad];
    
     // 设置导航条内容
    
    [self setUpNavgationBar];
    
    // 添加下拉刷新控件
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}

//  {:json字典 [:json数组

-(void)loadMoreStatus{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) {// 有微博数据，才需要下拉刷新
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        params[@"max_id"] = [NSString stringWithFormat:@"%lld",maxId];
    }
    params[@"access_token"] = [SZAccountTool account].access_token;
    
    // 发送get请求
    [mgr GET:https://api.weibo.com/2/statuses/friends_timeline.json parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
     // 结束上拉刷新
     
     [self.tableView footerEndRefreshing];
     
     // 获取到微博数据 转换成模型
     // 获取微博字典数组
     NSArray *dictArr = responseObject[@"statuses"];
     // 把字典数组转换成模型数组
     
     NSArray *statuses = (NSMutableArray *)[SZStatus objectArrayWithKeyValuesArray:dictArr];
     
     // 把数组中的元素添加进去

     [self.statuses addObjectsFromArray:statuses];
     
     // 刷新表格

     [self.tableView reloadData];
     
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
    
}

-(void)loadNewStatus{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        params[@"since_id"] = [self.statuses[0] idstr];
    }
    
    params[@"access_token"] = [SZAccountTool account].access_token;
    
}



-(void)setUpNavgationBar{
    
    //
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    //
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //
    SZTitleButton *titleButton = [SZTitleButton buttonWithType:UIButtonTypeCustom];

    
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    titleButton.adjustsImageWhenHighlighted = NO;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    

    
    
}

-(void)friendsearch{
    
    
    
}

-(void)pop{
    
    SZHomeOneViewController *homeOne = [[SZHomeOneViewController alloc] init];
     [self presentViewController:homeOne animated:YES completion:nil];
    
}

-(void)titleClick:(UIButton *)button{
    
    button.selected = !button.selected;
    // 弹出蒙板
    SZCover *cover = [SZCover show];
    cover.delegate = self;
    CGFloat popW = 200;
    CGFloat popX = (self.view.bounds.size.width - 200) * 0.5;
    CGFloat popH = 200;
    CGFloat popY = 55;
    
    SZPopMenu *menu = [SZPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}





// 点击蒙板的时候调用
-(void)coverDidClickCover:(SZCover *)cover{
    
    // 点击蒙板的时候调用
    [SZPopMenu hide];
    _titleButton.selected = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
