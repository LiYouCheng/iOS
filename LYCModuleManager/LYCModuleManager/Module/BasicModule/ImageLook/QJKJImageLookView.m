//
//  QJKJImageLookView.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJImageLookView.h"

#import "QJKJImageLookCell.h"

@interface QJKJImageLookView ()
<UICollectionViewDelegate,
UICollectionViewDataSource> {
    NSArray *_resourceArray;//资源
}

@property (nonatomic, strong) QJKJCollectionView *lookCollectionView;

@end

@implementation QJKJImageLookView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.alpha = 0;
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.lookCollectionView];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
    }
    return self;
}

- (QJKJCollectionView *)lookCollectionView {
    if (!_lookCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(self.width, self.height - 40 * 2);
        
        _lookCollectionView = [[QJKJCollectionView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.height - 40 * 2) collectionViewLayout:flowLayout];
        _lookCollectionView.pagingEnabled = YES;
        _lookCollectionView.dataSource = self;
        _lookCollectionView.delegate = self;
        
        [_lookCollectionView registerClass:[QJKJImageLookCell class] forCellWithReuseIdentifier:NSStringFromClass([QJKJImageLookCell class])];
    }
    return _lookCollectionView;
}

- (void)showImageLookView:(NSArray *)array {
    _resourceArray = array;
    
    [self.lookCollectionView reloadData];
    
    [[self superview] bringSubviewToFront:self];
    self.alpha = 1;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _resourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QJKJImageLookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QJKJImageLookCell class]) forIndexPath:indexPath];
    if (!cell) {
        DLog(@"未创建");
    }
    
    QJKJImageView *imageView = _resourceArray[indexPath.row];
    
    __weak QJKJImageLookView *weakSelf = self;
    [cell refreshUIWithImageView:imageView withFinishBlock:^{
        __strong QJKJImageLookView *strongSelf = weakSelf;
        strongSelf.alpha = 0;
    }];
    
    return cell;
}

@end
