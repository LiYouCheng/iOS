//
//  QJKJHomeVC.m
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJHomeVC.h"

#import "LSDropBoxView.h"
#import "LSDateSelectView.h"

@interface QJKJHomeVC () {
    UIButton *_button;
    NSArray *_contentArray;
}

@property (nonatomic, strong) LSDateSelectView *dateSelectView;

//@property (nonatomic, strong) LSDropBoxView *dropBoxView;

@end

@implementation QJKJHomeVC

- (LSDateSelectView *)dateSelectView {
    if (!_dateSelectView) {
        _dateSelectView = [[LSDateSelectView alloc] init];
    }
    return _dateSelectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentArray = @[
                      @{@"icon":@"消息",
                        @"name": @"消息中心"},
                      @{@"icon":@"仓库",
                        @"name": @"仓库中心"},
                      @{@"icon":@"消息",
                        @"name": @"消息中心"},
                      @{@"icon":@"仓库",
                        @"name": @"仓库中心"},
                      ];
    
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
    
    self.dateSelectView.sureBlock = ^(NSInteger timeInterval){
        NSLog(@"需要的时间 %d",timeInterval);
    };
    
    self.dateSelectView.minDateString = @"2016-12-20";
    self.dateSelectView.maxDateString = @"2016-12-24";
    
    [self.dateSelectView showDate];
    
    
//    btn.selected = !btn.selected;
    
//    //使用方式一、数据全自定义
//    __block NSInteger count = 0;
//    __weak NSArray *contentArray = _contentArray;
//    self.dropBoxView.countBlock = ^(void){
//        count = contentArray.count;
//        return count;
//    };
//    
//    __block NSString *iconStr = @"";
//    self.dropBoxView.imageBlock = ^(NSInteger row){
//        if (row < contentArray.count && row >= 0) {
//            NSDictionary *dict = contentArray[row];
//            iconStr = dict[@"icon"] ? dict[@"icon"] : @"";
//            
//        }
//        return iconStr;
//    };
//    
//    __block NSString *nameStr = @"";
//    self.dropBoxView.nameBlock = ^(NSInteger row){
//        if (row < contentArray.count && row >= 0) {
//            NSDictionary *dict = contentArray[row];
//            nameStr = dict[@"name"] ? dict[@"name"] : @"";
//            
//        }
//        return nameStr;
//    };
    
//    _contentArray = @[
//                      @{@"icon":@"消息",
//                        @"name": @"消息中心"},
//                      @{@"icon":@"仓库",
//                        @"name": @"仓库中心"},
//                      @{@"icon":@"消息",
//                        @"name": @"消息中心"},
//                      @{@"icon":@"仓库",
//                        @"name": @"仓库中心"},
//                      ];
//    
//    LSDropBoxView *dropBoxView = [[LSDropBoxView alloc] init];
//    dropBoxView.contentArray = _contentArray;
//    dropBoxView.selectBlock = ^(NSInteger row){
//        NSLog(@"选择某行 %zd",row);
//    };
//    [dropBoxView showDropBox];
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
