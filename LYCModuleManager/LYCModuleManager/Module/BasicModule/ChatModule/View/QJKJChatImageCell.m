//
//  QJKJChatImageCell.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJChatImageCell.h"

#import "QJKJChatInfoModel.h"



@implementation QJKJChatImageCell {
    QJKJImageView *_headImageView;//头像
    QJKJImageView *_bubbleImageView;//气泡
    
    QJKJImageView *_contentImageView;//内容
    QJKJChatInfoModel *_chatInfo;//
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
        
        _headImageView = [[QJKJImageView alloc] init];
        _headImageView.layer.cornerRadius = 5;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_headImageView];
        
        _bubbleImageView = [[QJKJImageView alloc] init];
        [self addSubview:_bubbleImageView];
        
        _contentImageView = [[QJKJImageView alloc] init];
        [self addSubview:_contentImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = [QJKJChatImageCell imageScaleShow:_contentImageView.image];
    UIImage *bubbleImage = nil;
    if (_chatInfo.ciUserType.integerValue == 2) {
        //右边
        _headImageView.frame = CGRectMake(self.width - 10 - 40, 10, 40, 40);
        
        _bubbleImageView.frame = CGRectMake(_headImageView.left - 5 - (size.width + 5 * 2), _headImageView.top, size.width + 5 * 2 + 5, size.height + 5 * 2);
        
        bubbleImage = [UIImage imageNamed:@"chat_right_bubble"];
    }
    else {
        //左边
        _headImageView.frame = CGRectMake(10, 10, 40, 40);
        
        _bubbleImageView.frame = CGRectMake(_headImageView.right + 5, _headImageView.top, size.width + 5 * 2 + 5, size.height + 5 * 2);
        bubbleImage = [UIImage imageNamed:@"chat_left_bubble"];
    }
    
    bubbleImage = [bubbleImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 40, 5, 40) resizingMode:UIImageResizingModeStretch];
    _bubbleImageView.image = bubbleImage;
    
    _contentImageView.frame = CGRectMake(_bubbleImageView.left + 5, _bubbleImageView.top + 5, size.width, size.height);
    
}

/**
 刷新图片显示
 
 @param model 数据
 @param clickBlock 点击图片
 */
- (void)refreshUIWithModel:(QJKJChatInfoModel *)model
            withClickBlock:(QJKJChatImageCellClickBlock)clickBlock {
    _chatInfo = model;
    
    NSData *dataImg = [[NSData alloc] initWithBase64EncodedString:model.ciBigPicture options:0];
    UIImage *image = [UIImage imageWithData:dataImg];
    _contentImageView.image = image;
    
    _contentImageView.isClick = YES;
    _contentImageView.clickBlock = ^(QJKJImageView *imageView){
        DLog(@"点击图片");
        
        clickBlock(imageView);
        
    };
}

#define IMAGE_MAX_WIDTH 100.f
//设定宽度最大100
+ (CGSize)imageScaleShow:(UIImage *)image
{
    CGFloat TW = image.size.width;
    CGFloat TH = image.size.height;
    
    if (TW > 100) {
        TH = TH * 100 / TW;
        TW = 100;
    }
    
    return CGSizeMake(TW, TH);

}

@end
