

//
//  GroupCahtViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/11/3.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "GroupChatViewController.h"
#import "ChatViewController.h"
#import "CreateGroupViewController.h"

@interface GroupChatViewController ()
{
    NSArray *arrGroup;
}
@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的群";
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(btnCreateGroup:)];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    //获取所有的群
    [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {
        if (!error) {
            arrGroup = [NSArray arrayWithArray:groups];
            [self.tableView reloadData];
        }
    } onQueue:nil];
    
}

#pragma mark - UITableView Delegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    EMGroup *group = [arrGroup objectAtIndex:indexPath.row];
    NSString *imageName = @"group_header";
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    if (group.groupSubject && group.groupSubject.length > 0) {
        cell.textLabel.text = group.groupSubject;
    }
    else {
        cell.textLabel.text = group.groupId;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMGroup *group = [arrGroup objectAtIndex:indexPath.row];
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:group.groupId isGroup:YES];
    chatController.title = group.groupSubject;
    [self.navigationController pushViewController:chatController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}


#pragma mark - Private Menthods

//新建一个群
- (void)btnCreateGroup:(id)sender
{
    CreateGroupViewController *createGroupVC = [[CreateGroupViewController alloc] init];
    [self.navigationController pushViewController:createGroupVC animated:YES];
}

@end
