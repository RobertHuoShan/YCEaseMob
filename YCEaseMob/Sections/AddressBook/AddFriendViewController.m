//
//  AddFriendViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/11/2.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()
{
    UITextField *textField;
}

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加好友";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem *btnItme = [[UIBarButtonItem alloc] initWithTitle:@"查找"
                                                                style:(UIBarButtonItemStyleDone)
                                                               target:self
                                                               action:@selector(btnSearch:)];
    self.navigationItem.rightBarButtonItem = btnItme;
    
    textField = [YCCommonCtrl commonTextFieldWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 35)
                                                        placeholder:@"用户名"
                                                              color:kColor_Gray
                                                               font:kFont_Title
                                                    secureTextEntry:NO
                                                           delegate:self];
    
    [YCCommonCtrl setViewBorderWithView:textField borderColor:kColor_LightGray borderWidth:1.0 cornerRadius:5.0]; //设置边框
    
    [self.view addSubview:textField];
    
}


#pragma mark - Private Menthods

//查找好友
- (void)btnSearch:(id)sender
{
    if (textField.text.length == 0) {
        UIAlertController *alterController = [YCCommonCtrl commonAlterControllerWithTitle:nil message:@"请先输入好友的用户名"];
        [self presentViewController:alterController animated:YES completion:nil];
        return;
    }

    UIView *view = [YCCommonCtrl commonViewWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 55) backgroundColor:kColor_White];
    [self.view addSubview:view];
    
    UIImageView *imgView = [YCCommonCtrl commonImageViewWithFrame:CGRectMake(10, 5, 45, 45) image:[UIImage imageNamed:@"chatListCellHead"]];
    [view addSubview:imgView];
    
    UILabel *label = [YCCommonCtrl commonLableWithFrame:CGRectMake(60, 5, SCREEN_WIDTH-150, 45)
                                                   text:textField.text
                                                  color:kColor_Gray
                                                   font:kFont_Title
                                          textAlignment:NSTextAlignmentLeft];
    label.numberOfLines = 0;
    [view addSubview:label];
    
    UIButton *btn = [YCCommonCtrl commonButtonWithFrame:CGRectMake(SCREEN_WIDTH-70, 10, 60, 35)
                                                  title:@"添加"
                                                  color:kColor_White
                                                   font:kFont_Button
                                        backgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue]
                                                 target:self
                                                 action:@selector(btnAdd:)];
    [YCCommonCtrl setViewBorderWithView:btn borderColor:kColor_Blue borderWidth:1.0 cornerRadius:5.0]; //设置边框
    [view addSubview:btn];
}

//发送添加好友申请
- (void)btnAdd:(id)sender
{
    EMError *error;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:textField.text message:@"我想加您为好友" error:&error];
    if (isSuccess && !error) {
        UIAlertController *alterController = [YCCommonCtrl commonAlterControllerWithTitle:nil message:@"消息已发送，等待对方验证"];
        [self presentViewController:alterController animated:YES completion:nil];
    }

}


@end
