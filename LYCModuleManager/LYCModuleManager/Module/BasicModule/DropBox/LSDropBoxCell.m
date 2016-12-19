//
//  LSDropBoxCell.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "LSDropBoxCell.h"

@implementation LSDropBoxCell {
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UIView *_lineView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor blueColor];
        [self addSubview:_iconImageView];
        
        _nameLabel              = [[UILabel alloc] init];
        _nameLabel.font         = [UIFont systemFontOfSize:13];
        _nameLabel.textColor    = [UIColor greenColor];
        _nameLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:_nameLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        [self addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _iconImageView.frame    = CGRectMake(5,(self.height - 20) / 2.0  , 20, 20);
    _nameLabel.frame        = CGRectMake(_iconImageView.right + 10, _iconImageView.top, self.width - (_iconImageView.right + 10) - 10, _iconImageView.height);
    _lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
}

/**
 *  刷新图片和名称
 *
 *  @param imageName 图片名字
 *  @param name      名字
 */
- (void)refreshUIWithImageName:(NSString *)imageName
                      withName:(NSString *)name {
    _iconImageView.image    = [UIImage imageNamed:imageName];
    _nameLabel.text         = name;
}

@end
