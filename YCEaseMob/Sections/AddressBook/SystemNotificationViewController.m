//
//  SystemNotificationViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/11/2.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "SystemNotificationViewController.h"

@interface SystemNotificationViewController ()
{
    NSMutableArray *arrList;
    
    NSString *username;
    
    NSUserDefaults *userDefaultes;

}

@end

@implementation SystemNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    arrList = [[NSMutableArray alloc] init];
    
    userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaultes objectForKey:@"dic"];
    
    if (dic.count >0) {
        username = [dic objectForKey:@"username"];
        [arrList addObject:dic];
    }
    self.tableView.rowHeight = 55.0f;
    
}


#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        UIButton *btnAccept = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 10.0, 60, 35.0)];
        [btnAccept setTag:100];
        [cell.contentView addSubview:btnAccept];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 10.0, 60, 35.0)];
        [btnCancel setTag:101];
        [cell.contentView addSubview:btnCancel];
    }
    
    NSDictionary *dic = [arrList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"username"];
    cell.textLabel.font = kFont_Title;
    cell.detailTextLabel.text = [dic objectForKey:@"message"];
    cell.detailTextLabel.font = kFont_Large;
    
    UIButton *btnAccept = (UIButton *)[cell viewWithTag:100];
    [btnAccept setTitle:@"同意" forState:UIControlStateNormal];
    [btnAccept setBackgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue] forState:UIControlStateNormal];
    [btnAccept addTarget:self action:@selector(btnAccept:) forControlEvents:UIControlEventTouchUpInside];
    [YCCommonCtrl setViewBorderWithView:btnAccept borderColor:kColor_Blue borderWidth:1.0f cornerRadius:5.0f];

    UIButton *btnCancel = (UIButton *)[cell viewWithTag:101];
    [btnCancel setTitle:@"拒绝" forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [YCCommonCtrl setViewBorderWithView:btnCancel borderColor:kColor_Blue borderWidth:1.0f cornerRadius:5.0f];

    
    return cell;
}


#pragma mark - Private Menthods

- (void)btnAccept:(id)sender
{
    //同意好友请求
    [[EaseMob sharedInstance].chatManager acceptBuddyRequest:username error:nil];
    
    [userDefaultes removeObjectForKey:@"dic"];
    
    [arrList removeAllObjects];
    [self.tableView reloadData];
}

- (void)btnCancel:(id)sender
{
    //拒绝好友请求
    [[EaseMob sharedInstance].chatManager rejectBuddyRequest:username reason:@"不认识你" error:nil];
    
    [userDefaultes removeObjectForKey:@"dic"];
    
    [arrList removeAllObjects];
    [self.tableView reloadData];

}



@end
