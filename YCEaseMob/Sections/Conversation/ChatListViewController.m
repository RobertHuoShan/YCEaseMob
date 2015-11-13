//
//  ChatListViewController.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/30.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatViewController.h"
#import "ConversationCell.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"


@interface ChatListViewController ()<IChatManagerDelegate, EMCallManagerDelegate,ChatViewControllerDelegate>
{
    NSArray *arrConversations;

}

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会话";

    //聊天管理器, 获取该对象后, 可以做登录、聊天、加好友等操作
    [[EaseMob sharedInstance].chatManager loadDataFromDatabase];

    [self getAllConversations]; //获取所有的会话
}

//获取所有的会话
- (void)getAllConversations
{
    arrConversations = [[EaseMob sharedInstance].chatManager conversations];
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrConversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CELL";
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    EMConversation *conversation = [arrConversations objectAtIndex:indexPath.row];
    
    switch (conversation.conversationType) {
        //单聊会话
        case eConversationTypeChat:
        {
            cell.labName.text = conversation.chatter;
            cell.imgHeader.image = [UIImage imageNamed:@"chatListCellHead"];
            break;


        }
        //群聊会话
        case eConversationTypeGroupChat:
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                    for (EMGroup *group in groupArray) {
                        if ([group.groupId isEqualToString:conversation.chatter]) {
                            cell.labName.text = group.groupSubject;
                            cell.imgHeader.image = [UIImage imageNamed:group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader"]  ;
                            break;
                        }
                    }

        }
        //聊天室会话
        case eConversationTypeChatRoom:
        {
            
        }
            
        default:
            break;
    }
    
    cell.labMsg.text = [self subTitleMessageByConversation:conversation]; //显示最后一条消息
    cell.labTime.text = [self lastMessageTimeByConversation:conversation]; //显示收到消息的时间


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = [arrConversations objectAtIndex:indexPath.row];
    
    ChatViewController *chatController;
    NSString *title = conversation.chatter;
    
    NSString *chatter = conversation.chatter;
    
    chatController = [[ChatViewController alloc] initWithChatter:chatter
                                                conversationType:conversation.conversationType];
    chatController.title = title;
    
    chatController.delelgate = self;
    [self.navigationController pushViewController:chatController animated:YES];
    
}

//得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            //图像类型
            case eMessageBodyType_Image:
            {
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            //文本类型
            case eMessageBodyType_Text:
            {
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];  //表情映射
                ret = didReceiveText;
            } break;
            //语音类型
            case eMessageBodyType_Voice:
            {
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            //位置类型
            case eMessageBodyType_Location:
            {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            //视频类型
            case eMessageBodyType_Video:
            {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
                
            default:
            break;
        }
    }
    
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    //return @"http://img0.bdstatic.com/img/image/shouye/jianbihua0525.jpg";
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

@end
