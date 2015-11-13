//
//  CreateGroupViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/11/3.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "CreateGroupViewController.h"

@interface CreateGroupViewController ()
{
    NSArray *arrFriends;
    NSMutableArray *arrSelected;
}

@property (retain, nonatomic) UITextField *textFieldName;
@property (retain, nonatomic) UITextView *textViewDes;
@property (retain, nonatomic) UIActivityIndicatorView *activityView;
@end

@implementation CreateGroupViewController
@synthesize textFieldName,textViewDes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.center = self.tableView.center;
    _activityView.color = [UIColor blackColor];
    
    [self.view addSubview:_activityView];

    
    self.title = @"新建群";
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(btnClickDone:)];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    arrSelected = [[NSMutableArray alloc] init];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    EMBuddy *eMBuddy = [arrFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = eMBuddy.username;
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath]; //得到当前选中的cell
    
    if (cell.accessoryType  == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [arrSelected removeObject:[arrFriends objectAtIndex:indexPath.row]];
    }else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arrSelected addObject:[arrFriends objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"%ld",arrSelected.count);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 170.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [YCCommonCtrl commonViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 165) backgroundColor:kColor_White];
    
    textFieldName = [YCCommonCtrl commonTextFieldWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 35)
                                                            placeholder:@"群聊名称"
                                                                  color:kColor_Gray
                                                                   font:kFont_Title
                                                        secureTextEntry:NO
                                                               delegate:self];
    
    [YCCommonCtrl setViewBorderWithView:textFieldName borderColor:kColor_LightGray borderWidth:1.0f cornerRadius:5.0f];
    [headerView addSubview:textFieldName];
    
    textViewDes = [YCCommonCtrl commonTextViewWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 80)
                                                               text:@""
                                                              color:kColor_Gray
                                                               font:kFont_Title
                                                      textAlignment:NSTextAlignmentLeft];
    [YCCommonCtrl setViewBorderWithView:textViewDes borderColor:kColor_LightGray borderWidth:1.0f cornerRadius:5.0f];
    [headerView addSubview:textViewDes];
    
    UILabel *label = [YCCommonCtrl commonLableWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 15)
                                                    text:@"请选择群成员"
                                                   color:kColor_Blue
                                                    font:kFont_Large
                                            textAlignment:NSTextAlignmentLeft];
    [headerView addSubview:label];
    
    return headerView;
}



#pragma mark - Private Menthods

- (void)btnClickDone:(id)sender
{
    NSMutableArray *arrName = [[NSMutableArray alloc] init];
    for (EMBuddy *eMBuddy in arrSelected ) {
        [arrName addObject:eMBuddy.username];
    }
    
    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
    groupStyleSetting.groupMaxUsersCount = 500;
    groupStyleSetting.groupStyle = eGroupStyle_PrivateOnlyOwnerInvite;
    
    [self.activityView startAnimating];
    
    [[EaseMob sharedInstance].chatManager asyncCreateGroupWithSubject:textFieldName.text
                                                          description:textViewDes.text
                                                             invitees:arrName
                                                initialWelcomeMessage:@"hello"
                                                         styleSetting:groupStyleSetting
                                                           completion:^(EMGroup *group, EMError *error) {
                                                               if(!error){
                                                                   
                                                                   [self.activityView stopAnimating];
                                                                   
                                                                   UIAlertController *alterController = [UIAlertController alertControllerWithTitle:nil
                                                                                                                                            message:@"创建成功"
                                                                                                                                     preferredStyle:UIAlertControllerStyleAlert];
                                                                   [self presentViewController:alterController animated:YES completion:nil];
                                                                   
                                                                   UIAlertAction *alterAction = [UIAlertAction actionWithTitle:@"确定"
                                                                                                                         style:UIAlertActionStyleDefault
                                                                                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                                                                                           [self.navigationController popViewControllerAnimated:YES];
                                                                                                                       }];
                                                                   [alterController addAction:alterAction];
                                                                   
                                                                   
                                                               }
                                                           }
                                                              onQueue:nil];
}


@end
