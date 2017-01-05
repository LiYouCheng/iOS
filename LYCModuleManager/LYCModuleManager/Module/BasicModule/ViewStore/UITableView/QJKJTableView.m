//
//  QJKJTableView.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJTableView.h"

@implementation QJKJTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    
    if (!self.dragging) {
        [self.nextResponder touchesEnded: touches withEvent:event];
    }
    
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    
    [super touchesBegan:touches withEvent:event];
}

@end
