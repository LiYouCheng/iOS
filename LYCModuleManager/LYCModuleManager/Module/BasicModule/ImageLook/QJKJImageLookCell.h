//
//  QJKJImageLookCell.h
//  LYCModuleManager
//
//  Created by YouchengLi on 2017/1/6.
//  Copyright © 2017年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QJKJImageScrollView.h"

typedef void(^QJKJImageLookCellFinishBlock)(void);

@interface QJKJImageLookCell : UICollectionViewCell
<QJKJImageScrollViewDelegate>

- (void)refreshUIWithImageView:(QJKJImageView *)imageView
               withFinishBlock:(QJKJImageLookCellFinishBlock)finishBlock;

@end
