//
//  SettingsViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/30.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏列表分割线
    
    UIButton *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 35)];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    [btnExit setTitleColor:kColor_White forState:UIControlStateNormal];
    btnExit.backgroundColor = kColor_Blue;
    [btnExit addTarget:self action:@selector(btnExit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnExit];
}

- (void)btnExit:(id)sender
{
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (error && error.errorCode != EMErrorServerNotLogin) {
            
        }
        else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    } onQueue:nil];

}

@end
