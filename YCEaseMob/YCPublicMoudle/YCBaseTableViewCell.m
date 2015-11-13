//
//  YCBaseTableViewCell.m
//  YCEaseMob
//
//  Created by 袁灿 on 15/10/29.
//  Copyright © 2015年 yuancan. All rights reserved.
//

#import "YCBaseTableViewCell.h"

@implementation YCBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)setDictInfo:(NSDictionary *)dictInfo
{
    _dictInfo = dictInfo;
}


@end
