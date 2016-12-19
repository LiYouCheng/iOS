//
//  QJKJHomeVC.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJHomeVC.h"

#import "LSDropBoxView.h"

@interface QJKJHomeVC () {
    UIButton *_button;
}

@property (nonatomic, strong) LSDropBoxView *dropBoxView;

@end

@implementation QJKJHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 100, 50);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(clickedDropBox:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"展开" forState:UIControlStateNormal];
    [self.view addSubview:button];
    _button = button;
}

- (void)clickedDropBox:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    self.dropBoxView.countBlock = ^(void){
        return 4;
    };
    self.dropBoxView.imageBlock = ^(NSInteger row){
        return @"icon";
    };
    self.dropBoxView.nameBlock = ^(NSInteger row){
        return @"测试你的";
    };
    self.dropBoxView.selectBlock = ^(NSInteger row){
        NSLog(@"选择某行 %zd",row);
    };
    
    [self.dropBoxView showDropBox];
}

/**
 *  下拉框
 *
 *  @return return value description
 */
- (LSDropBoxView *)dropBoxView {
    if (!_dropBoxView) {
        _dropBoxView = [[LSDropBoxView alloc] init];
    }
    return _dropBoxView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
