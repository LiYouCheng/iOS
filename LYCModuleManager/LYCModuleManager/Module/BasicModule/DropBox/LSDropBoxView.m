//
//  LSDropBoxView.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "LSDropBoxView.h"

#import "LSDropBoxCell.h"

#define CELL_HEIGHT 44.f//cell高度

#define ARROW_HEIGHT 8.f//箭头宽度
#define ARROW_WIDTH 15.f//箭头高度

#define LS_SHOW_WIDTH 120 //显示宽度
#define MAX_CELL_LINE 5 //cell最大行数

@interface LSDropBoxView ()
<UITableViewDataSource,
UITableViewDelegate>

@end

@implementation LSDropBoxView {
    UIView          *_bgView;//背景
    CAShapeLayer    *_arrowLayer;//箭头
    UIView          *_showView;//显示
    UITableView     *_contentTableView;//加载
    CGPoint         _anchorPoint;//锚点
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        //大背景
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_bgView];
        
        //显示
        _showView = [[UIView alloc] init];
        [self addSubview:_showView];

        //数据
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.layer.cornerRadius = 5;
        _contentTableView.layer.borderWidth = 0.5;
        _contentTableView.clipsToBounds = YES;
        _contentTableView.layer.borderColor = [UIColor blackColor].CGColor;
        _contentTableView.userInteractionEnabled = YES;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        [_showView addSubview:_contentTableView];
    }
    return self;
}

#pragma mark - 触摸消失

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenDropBox];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_countBlock) {
        return _countBlock();
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([LSDropBoxCell class]);
    LSDropBoxCell *dropBoxCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!dropBoxCell) {
        dropBoxCell = [[LSDropBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *imageName = @"";
    NSString *name = @"";
    if (_imageBlock) {
        imageName = _imageBlock(indexPath.row);
    }
    if (_nameBlock) {
        name = _nameBlock(indexPath.row);
    }
    [dropBoxCell refreshUIWithImageName:imageName
                               withName:name];
    
    return dropBoxCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectBlock) {
        _selectBlock(indexPath.row);
    }
    [self hiddenDropBox];
}

- (void)setContentArray:(NSArray *)contentArray {
    __block NSInteger count = contentArray.count;
    self.countBlock = ^(void){
        return count;
    };
    
    __block NSString *iconStr = @"";
    self.imageBlock = ^(NSInteger row){
        if (row < contentArray.count && row >= 0) {
            NSDictionary *dict = contentArray[row];
            iconStr = dict[@"icon"] ? dict[@"icon"] : @"";
            
        }
        return iconStr;
    };
    
    __block NSString *nameStr = @"";
    self.nameBlock = ^(NSInteger row){
        if (row < contentArray.count && row >= 0) {
            NSDictionary *dict = contentArray[row];
            nameStr = dict[@"name"] ? dict[@"name"] : @"";
            
        }
        return nameStr;
    };
}

#pragma mark - 显示和隐藏

/**
 *  显示下拉框
 *
 */
- (void)showDropBox {
    [self beforeShowSet];

    _showView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:0.3f animations:^{
        _showView.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        [_contentTableView reloadData];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/**
 *  隐藏下拉框
 */
- (void)hiddenDropBox {
    [UIView animateWithDuration:0.3f animations:^{
        _showView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        _showView.transform= CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];
}

//#pragma mark - 计算弹出位置
//- (CGRect)targetView:(UIView *)targetView {
//    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:targetView.frame fromView:targetView.superview];
//    return rect;
//}

#pragma mark -

/**
 显示的行数
 
 @return 多少行
 */
- (NSInteger)cellLine {
    return _countBlock ? _countBlock() : 0;
}


/**
 显示之前进行设置
 */
- (void)beforeShowSet {
    //锚点设置0.875
    _anchorPoint = CGPointMake(0.8, 0);
    
    //最多MAX_CELL_LINE行的高度
    CGFloat showViewHeight = CELL_HEIGHT * ([self cellLine] < MAX_CELL_LINE ? [self cellLine] : MAX_CELL_LINE) + ARROW_HEIGHT;
    
    _showView.layer.anchorPoint = _anchorPoint;
    
    _showView.frame = CGRectMake(self.width - 10 - LS_SHOW_WIDTH, 64,LS_SHOW_WIDTH , showViewHeight);
    
    _contentTableView.frame = CGRectMake(0, ARROW_HEIGHT, _showView.width, _showView.height - ARROW_HEIGHT);
    
    [self drawArrow];
    
}

/**
 三角形
 */
- (void)drawArrow {
    CGPoint anchorPoint = _anchorPoint;
    CGFloat viewHeight = _showView.height;
    CGFloat viewWidth = LS_SHOW_WIDTH;
    CGFloat arrowHeight = ARROW_HEIGHT;
    CGFloat arrow_W = ARROW_WIDTH;
    
    CGPoint arrow1 = CGPointMake(viewWidth * anchorPoint.x , viewHeight * anchorPoint.y);
    CGFloat bottomY = anchorPoint.y==0?(arrowHeight):(viewHeight - arrowHeight);
    CGPoint arrow2 = CGPointMake(arrow1.x + (arrow_W/2 >= viewWidth*(1-anchorPoint.x)?0:arrow_W/2),bottomY);
    CGPoint arrow3 = CGPointMake(arrow1.x - (arrow_W/2 >= viewWidth*anchorPoint.x?0:arrow_W/2), bottomY);
    
    if (!_arrowLayer) {
        _arrowLayer = [[CAShapeLayer alloc] init];
        _arrowLayer.fillColor = [UIColor grayColor].CGColor;
        _arrowLayer.strokeColor = [UIColor blackColor].CGColor;
        _arrowLayer.lineWidth = 0.5;
        [_showView.layer addSublayer:_arrowLayer];
    }
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:arrow1];
    [arrowPath addLineToPoint:arrow2];
    [arrowPath addLineToPoint:arrow3];
    [arrowPath closePath];
    _arrowLayer.path = arrowPath.CGPath;
}

@end
