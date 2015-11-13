//
//  ConversationCell.h
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/23.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "YCBaseTableViewCell.h"

@interface ConversationCell : YCBaseTableViewCell

@property (retain, nonatomic) UILabel *labName;
@property (retain, nonatomic) UILabel *labMsg;
@property (retain, nonatomic) UILabel *labTime;
@property (retain, nonatomic) UIImageView *imgHeader;

@end
