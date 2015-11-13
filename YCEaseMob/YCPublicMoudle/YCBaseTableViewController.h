//
//  YCBaseTableViewController.h
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/29.
//  Copyright © 2015年 yuancan. All rights reserved.
//  UITableView的基类

#import "YCBaseViewController.h"

@interface YCBaseTableViewController : YCBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;

@end
