//
//  LoginViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/23.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "YCTabBarViewController.h"
#import "YCTabBarViewController.h"

@interface LoginViewController ()
{
    UITextField *txtAccount;
    UITextField *txtPsw;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"环信即时通讯Demo";
    self.navigationItem.hidesBackButton = YES;
    
    NSInteger labWidth = 60;
    NSInteger txtWidth = 150;
    
    UILabel *labAccount = [YCCommonCtrl commonLableWithFrame:CGRectMake((SCREEN_WIDTH-labWidth-txtWidth)/2, 150, labWidth, 30)
                                                        text:@"账号:"
                                                       color:[UIColor blackColor]
                                                        font:[UIFont systemFontOfSize:17.0]
                                               textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:labAccount];
    
    UILabel *labPsw = [YCCommonCtrl commonLableWithFrame:CGRectMake((SCREEN_WIDTH-labWidth-txtWidth)/2, 200, labWidth, 30)
                                                    text:@"密码:"
                                                   color:[UIColor blackColor]
                                                    font:[UIFont systemFontOfSize:17.0]
                                           textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:labPsw];
    
    txtAccount = [YCCommonCtrl commonTextFieldWithFrame:CGRectMake(CGRectGetMaxX(labAccount.frame), CGRectGetMinY(labAccount.frame),txtWidth, 30)
                                            placeholder:nil
                                                  color:[UIColor blackColor]
                                                   font:[UIFont systemFontOfSize:17.0]
                                        secureTextEntry:NO
                                               delegate:self];
    
    [YCCommonCtrl setViewBorderWithView:txtAccount
                            borderColor:kColor_Gray
                            borderWidth:1.0
                           cornerRadius:2.0]; //设置边框
    [self.view addSubview:txtAccount];
    
    txtPsw = [YCCommonCtrl commonTextFieldWithFrame:CGRectMake(CGRectGetMaxX(labPsw.frame), CGRectGetMinY(labPsw.frame),txtWidth, 30)
                                        placeholder:nil
                                              color:[UIColor blackColor]
                                               font:[UIFont systemFontOfSize:17.0]
                                    secureTextEntry:YES
                                           delegate:self];
    
    [YCCommonCtrl setViewBorderWithView:txtPsw borderColor:kColor_Gray borderWidth:1.0 cornerRadius:2.0]; //设置边框
    [self.view addSubview:txtPsw];
    
    
    UIButton *btnLogin = [YCCommonCtrl commonButtonWithFrame:CGRectMake((SCREEN_WIDTH-labWidth-txtWidth)/2, CGRectGetMaxY(labPsw.frame)+50, labWidth+txtWidth, 35)
                                                       title:@"登陆"
                                                       color:kColor_White
                                                        font:[UIFont systemFontOfSize:17.0f]
                                             backgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue]
                                                      target:self
                                                      action:@selector(btnClickLogin)];
    [self.view addSubview:btnLogin];
    
    UIButton *btnRegister = [YCCommonCtrl commonButtonWithFrame:CGRectMake((SCREEN_WIDTH-labWidth-txtWidth)/2, CGRectGetMaxY(btnLogin.frame)+30, labWidth+txtWidth, 35)
                                                          title:@"注册"
                                                          color:kColor_White
                                                           font:[UIFont systemFontOfSize:17.0f]
                                                backgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue]
                                                         target:self
                                                         action:@selector(btnClickRegister)];
    [self.view addSubview:btnRegister];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
    
    //测试账号
    txtAccount.text = @"yuancan001";
    txtPsw.text = @"123";
    
}

//注册
- (void)btnClickRegister
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//登陆
- (void)btnClickLogin
{
    //异步登陆的方法
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:txtAccount.text password:txtPsw.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            
            YCTabBarViewController *tabBarVC = [[YCTabBarViewController alloc] init];
            [self.navigationController pushViewController:tabBarVC animated:YES];
            NSLog(@"登陆成功");
           
        }
    } onQueue:nil];
}

#pragma mark - Hidden Keyboard

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGPoint point = [textField convertPoint:CGPointMake(0, 0) toView:self.view];
    
    float height = textField.frame.size.height+point.y+256+42+20; //256键盘高度，42中文联想提示框高度 ,20修正值
    
    if (height > SCREEN_HEIGHT) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
    
    return YES;
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)hiddenKeyBoard
{
    [txtAccount resignFirstResponder];
    [txtPsw resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}


@end
