//
//  YCTabBarViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/30.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "YCTabBarViewController.h"
#import "ChatListViewController.h"
#import "AddressBookViewController.h"
#import "SettingsViewController.h"
#import "AddFriendViewController.h"

@interface YCTabBarViewController ()
{
    UIBarButtonItem *btnAddFriend;
}

@end

@implementation YCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES; //隐藏系统的返回按钮
    
    ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
    chatListVC.tabBarItem.title = @"会话";
    chatListVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_chatsHL"];
    chatListVC.tabBarItem.tag = 0;
    
    AddressBookViewController *addressBookVC = [[AddressBookViewController alloc] init];
    addressBookVC.tabBarItem.title = @"通讯录";
    addressBookVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_contactsHL"];
    addressBookVC.tabBarItem.tag = 1;
    
    SettingsViewController *settingVC = [[SettingsViewController alloc] init];
    settingVC.tabBarItem.title = @"设置";
    settingVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_settingHL"];
    settingVC.tabBarItem.tag = 2;

    self.viewControllers = @[chatListVC,addressBookVC,settingVC];
    
    btnAddFriend = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                 target:self
                                                                 action:@selector(btnAddFriend:)];
}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.title = @"会话";
        self.navigationItem.rightBarButtonItem = nil;
    }else if (item.tag == 1){
        self.title = @"通讯录";
        self.navigationItem.rightBarButtonItem = btnAddFriend;
    }else if (item.tag == 2){
        self.title = @"设置";
        self.navigationItem.rightBarButtonItem = nil;
    }
}


#pragma mark - Private Menthods

//添加好友
- (void)btnAddFriend:(id)sender
{
    AddFriendViewController *addFriendVC = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}

@end
