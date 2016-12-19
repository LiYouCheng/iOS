//
//  UIView+QJKJBase.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "UIView+QJKJBase.h"

@implementation UIView (QJKJBase)

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

#pragma mark - 高度
- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)newHeight {
    CGRect newframe = self.frame;
    newframe.size.height = newHeight;
    self.frame = newframe;
}

#pragma mark - 宽度
- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void) setWidth:(CGFloat)newWidth {
    CGRect newframe = self.frame;
    newframe.size.width = newWidth;
    self.frame = newframe;
}

#pragma mark - 上
- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)newTop {
    CGRect newframe = self.frame;
    newframe.origin.y = newTop;
    self.frame = newframe;
}

#pragma mark - 左
- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)newLeft {
    CGRect newframe = self.frame;
    newframe.origin.x = newLeft;
    self.frame = newframe;
}

#pragma mark - 下
- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)newBottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newBottom - CGRectGetHeight(self.frame);
    self.frame = newframe;
}

#pragma mark - 右
- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)newRight {
    CGRect newframe = self.frame;
    newframe.origin.x = newRight - CGRectGetWidth(self.frame);
    self.frame = newframe;
}

@end
