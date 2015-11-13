//
//  AppDelegate.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/29.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()<IChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化环信SDK
    [[EaseMob sharedInstance] registerSDKWithAppKey:APPKEY apnsCertName:APNSCert];
    
    //注册一个监听对象到监听列表中
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = navigation;
    
    //设置系统导航条的背景颜色和标题颜色
    [[UINavigationBar appearance] setBackgroundImage:[YCCommonCtrl imageWithColor:kColor_Blue] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[YCCommonCtrl imageWithColor:kColor_Blue]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:FONT(18),NSForegroundColorAttributeName:kColor_White}];
    [[UINavigationBar appearance] setTintColor:kColor_White];

    return YES;
}

//监听好友申请消息
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:username,@"username",message,@"message", nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:dic forKey:@"dic"];
    
    [userDefaults synchronize];
    
    NSString *title = [NSString stringWithFormat:@"来自%@的好友申请",username];
    UIAlertController *alterController = [YCCommonCtrl commonAlterControllerWithTitle:title message:message];
    [self.window.rootViewController presentViewController:alterController animated:YES completion:nil];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
