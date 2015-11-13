//
//  AddressBookViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/30.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "AddressBookViewController.h"
#import "ChatViewController.h"
#import "SystemNotificationViewController.h"
#import "GroupChatViewController.h"

@interface AddressBookViewController ()
{
    NSArray *arrSystem;
    NSArray *arrFriends;
}

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.tabBarController.title = @"通讯录";
    
    arrSystem = @[@"申请与通知",@"群聊",@"聊天室"];

    //获取好友列表
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            arrFriends = [NSArray arrayWithArray:buddyList];
            [self.tableView reloadData];
        }
    } onQueue:nil];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return arrSystem.count;
    } else {
        return arrFriends.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = [arrSystem objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@"groupPublicHeader"];
            break;
        }
         
        case 1:
        {
            EMBuddy *eMBuddy = [arrFriends objectAtIndex:indexPath.row];
            cell.textLabel.text = eMBuddy.username;
            cell.imageView.image = [UIImage imageNamed:@"chatListCellHead"];

            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                SystemNotificationViewController *sysVC = [[SystemNotificationViewController alloc] init];
                [self.navigationController pushViewController:sysVC animated:YES];
                break;
            }
            case 1:
            {
                GroupChatViewController *groupChatVC = [[GroupChatViewController alloc] init];
                [self.navigationController pushViewController:groupChatVC animated:YES];
                break;
            }
                
            default:
                break;
        }
    }else {
        EMBuddy *buddy = [arrFriends objectAtIndex:indexPath.row];
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:buddy.username isGroup:NO];
        chatVC.title = buddy.username; //好友的名字
        
        [self.navigationController pushViewController:chatVC animated:YES];
    }
}

//设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

//设置表尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

//添加标头中的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UILabel *label;
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 20)];
        label.font = FONT(13);
        [headerView addSubview:label];
    }
    
    if (section == 0) {
        label.text = @"我的好友";
    }else if (section == 1){
        label.text = @"我的群组";
    }
    
    return headerView;
}

@end
