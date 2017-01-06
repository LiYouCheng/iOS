//
//  QJKJChatTimeCell.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatTimeCell.h"

#import "QJKJChatInfoModel.h"
#import "QJKJDateShareHelper.h"

#pragma mark - 位置信息


//时间显示顶部位置
#define CHAT_TIMECELL_TIME_TOP 10.f
//时间显示宽度
#define CHAT_TIMECELL_TIME_WIDTH 150.f

@implementation QJKJChatTimeCell {
    QJKJLabel *_timeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor grayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _timeLabel                      = [[QJKJLabel alloc] init];
        _timeLabel.textAlignment        = NSTextAlignmentCenter;
        _timeLabel.backgroundColor      = [UIColor lightGrayColor];
        _timeLabel.font                 = [UIFont systemFontOfSize:13];
        _timeLabel.layer.masksToBounds  = YES;
        _timeLabel.textColor            = [UIColor whiteColor];
        _timeLabel.layer.cornerRadius   = 5;
        [self addSubview:_timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _timeLabel.frame = CGRectMake((self.width - CHAT_TIMECELL_TIME_WIDTH)/2, CHAT_TIMECELL_TIME_TOP, CHAT_TIMECELL_TIME_WIDTH, self.height - CHAT_TIMECELL_TIME_TOP * 2);
}

/**
 刷新时间显示
 
 @param model 数据
 */
- (void)refreshUIWithModel:(QJKJChatInfoModel *)model {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:model.ciUpdateTime.integerValue];
    NSString *timeString = [QJKJDateShareHelper qjkjStringFromDate:date withFormatString:@"yyyy年MM月dd日 HH:mm"];
    _timeLabel.text = timeString;
}

@end
