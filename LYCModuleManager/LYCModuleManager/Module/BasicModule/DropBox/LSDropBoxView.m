//
//  LSDropBoxView.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "LSDropBoxView.h"

#import "LSDropBoxCell.h"

@interface LSDropBoxView ()
<UITableViewDataSource,
UITableViewDelegate>

@end

@implementation LSDropBoxView {
    UIView *_bgView;
    UIImageView *_bgImageView;
    UITableView *_contentTableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor redColor];
        [self addSubview:_bgView];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 20 - 10, 64 - 20, 20, 20)];
        _bgImageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_bgImageView];
        
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(_bgImageView.left, _bgImageView.top + 20, _bgImageView.width, _bgImageView.height - 20) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.userInteractionEnabled = YES;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_contentTableView];
    }
    return self;
}

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

#pragma mark - CustomMethond

/**
 *  显示下拉框
 *
 */
- (void)showDropBox {
    NSInteger count = _countBlock();
    [UIView animateWithDuration:0.25 animations:^{
        _bgImageView.frame = CGRectMake(self.width - 100 - 10, 64 - 20, 100, count * 44 + 20);
        _contentTableView.frame = CGRectMake(_bgImageView.left, _bgImageView.top + 20, _bgImageView.width, _bgImageView.height - 20);
    } completion:^(BOOL finished) {
        [_contentTableView reloadData];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/**
 *  隐藏下拉框
 */
- (void)hiddenDropBox {
    [UIView animateWithDuration:0.25 animations:^{
        _bgImageView.frame = CGRectMake(self.width - 20 - 10, 64 - 20, 20, 20);
        _contentTableView.frame = CGRectMake(_bgImageView.left, _bgImageView.top + 20, _bgImageView.width, _bgImageView.height - 20);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
