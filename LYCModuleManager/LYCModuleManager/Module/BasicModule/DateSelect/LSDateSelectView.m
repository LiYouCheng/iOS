//
//  LSDateSelectView.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2016/12/22.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "LSDateSelectView.h"

@implementation LSDateSelectView {
    UIView          *_alphaView;
    UIView          *_toolView;
    UIButton        *_sureButton;
    UIDatePicker    *_datePicker;
    
    NSTimeInterval  _minDateInterval;
    NSTimeInterval  _maxDateInterval;
    NSDateFormatter *_dateFormater;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _alphaView = [[UIView alloc] initWithFrame:self.bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
        [self addSubview:_alphaView];
        
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 40)];
        _toolView.backgroundColor = [UIColor grayColor];
        [self addSubview:_toolView];
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(_toolView.width - 60 - 10, 5, 60, 30);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(clickedSure) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:_sureButton];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _toolView.bottom, self.width, 220)];
//        [_datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
//        _datePicker.minimumDate = [NSDate date];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_datePicker];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenDate)];
        [self addGestureRecognizer:tap];
        
        _dateFormater = [[NSDateFormatter alloc] init];
//        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//        [_dateFormater setTimeZone:timeZone];
        [_dateFormater setLocale:[NSLocale currentLocale]];
        [_dateFormater setDateFormat:@"yyyy-MM-dd"];
        
        //默认区域
        self.minDateString = @"1970-01-01";
        self.maxDateString = @"10000-01-01";
        
    }
    return self;
}

#pragma mark - 配置相关

#pragma mark - setter

- (void)setMinDateString:(NSString *)minDateString {
    if ([minDateString length] > 0) {
        NSDate *date = [_dateFormater dateFromString:minDateString];
        _minDateInterval = [date timeIntervalSince1970];
    }
    else {
        _minDateInterval = CGFLOAT_MIN;
    }
}

- (void)setMaxDateString:(NSString *)maxDateString {
    if ([maxDateString length] > 0) {
        NSDate *date = [_dateFormater dateFromString:maxDateString];
        _maxDateInterval = [date timeIntervalSince1970];
    }
    else {
        _maxDateInterval = CGFLOAT_MAX;
    }
    
}

//#pragma mark - 时间变化
//
//- (void)dateChange:(UIDatePicker *)datePicker {
//    
//    _selectDate = datePicker.date;
//    
//    NSLog(@"date = %@",datePicker.date);
//}

#pragma mark - 显示相关

/**
 显示时间
 */
- (void)showDate {
    
    if (_minDateInterval > _maxDateInterval) {
        NSLog(@"设置错误");
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        _toolView.top = [UIScreen mainScreen].bounds.size.height - 40 - 220;
        _datePicker.top = _toolView.bottom;
    }];
}

/**
 隐藏时间
 */
- (void)hiddenDate {

    [UIView animateWithDuration:0.25 animations:^{
        _toolView.top = [UIScreen mainScreen].bounds.size.height;
        _datePicker.top = _toolView.bottom;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - 点击确认

/**
 点击确认
 */
- (void)clickedSure {
    
    NSTimeInterval currentTimeInterval = [_datePicker.date timeIntervalSince1970];
    if (currentTimeInterval < _minDateInterval) {
        NSLog(@"当前选择的时间不合法");
        return;
    }
    
    if (currentTimeInterval > _maxDateInterval) {
        NSLog(@"当前选择的时间不合法");
        return;
    }
    
    if (_sureBlock) {
        _sureBlock((NSInteger)currentTimeInterval);
    }
    else {
        NSLog(@"块未设置");
    }

    [self hiddenDate];
}

@end
