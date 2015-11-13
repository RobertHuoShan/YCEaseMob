//
//  RegisterViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/23.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "RegisterViewController.h"
#import "EMError.h"
#import "EaseMob.h"

@interface RegisterViewController ()
{
    UITextField *txtAccount;
    UITextField *txtPsw;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    
    [YCCommonCtrl setViewBorderWithView:txtPsw
                            borderColor:kColor_Gray
                            borderWidth:1.0
                           cornerRadius:2.0]; //设置边框
    [self.view addSubview:txtPsw];
    
    
    UIButton *btnRegister = [YCCommonCtrl commonButtonWithFrame:CGRectMake((SCREEN_WIDTH-labWidth-txtWidth)/2, CGRectGetMaxY(labPsw.frame)+50, labWidth+txtWidth, 35)
                                                          title:@"注册"
                                                          color:[UIColor blackColor]
                                                           font:[UIFont systemFontOfSize:17.0f]
                                                backgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue]
                                                         target:self
                                                         action:@selector(btnClickRegister)];
    [self.view addSubview:btnRegister];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
    
}

//注册
- (void)btnClickRegister
{
    //异步方法
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:txtAccount.text password:txtPsw.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
            
            UIAlertController *alterController= [UIAlertController alertControllerWithTitle:nil
                                                                                    message:@"注册成功"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alterController animated:YES completion:nil];
            
            UIAlertAction *alterAction = [UIAlertAction actionWithTitle:@"确定"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:nil];
            [alterController addAction:alterAction];
            
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
