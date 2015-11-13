//
//  ConversationCell.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/23.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "ConversationCell.h"

@implementation ConversationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        _imgHeader = [YCCommonCtrl commonImageViewWithFrame:CGRectMake(10, 5, 40, 40) image:[UIImage imageNamed:@""]];
        [self addSubview:_imgHeader];
        
        _labName = [YCCommonCtrl commonLableWithFrame:CGRectMake(55, 5, 250, 20)
                                                 text:@""
                                                color:[UIColor blackColor]
                                                 font:[UIFont systemFontOfSize:17.0]
                                        textAlignment:NSTextAlignmentLeft];
        [self addSubview:_labName];
        
        _labMsg = [YCCommonCtrl commonLableWithFrame:CGRectMake(55, 25, 250, 20)
                                                 text:@""
                                                color:[UIColor grayColor]
                                                 font:[UIFont systemFontOfSize:17.0]
                                        textAlignment:NSTextAlignmentLeft];
        [self addSubview:_labMsg];
        
        _labTime = [YCCommonCtrl commonLableWithFrame:CGRectMake(SCREEN_WIDTH-130, 5, 130, 20)
                                                text:@""
                                               color:[UIColor grayColor]
                                                font:[UIFont systemFontOfSize:15.0]
                                       textAlignment:NSTextAlignmentLeft];
        [self addSubview:_labTime];
        
    }
    
    return self;
}

- (void)setDictInfo:(NSDictionary *)dictInfo
{
    
}
@end
