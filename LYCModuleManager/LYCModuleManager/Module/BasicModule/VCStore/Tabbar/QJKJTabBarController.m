//
//  QJKJTabBarController.m
//  LYCModuleManager
//
//  Created by YouchengLi on 2016/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import "QJKJTabBarController.h"

#import "QJKJHomeVC.h"

@interface QJKJTabBarController ()

@property (nonatomic, strong) QJKJHomeVC *homeVC;

@end

@implementation QJKJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHome];
    
    
}

- (void)initHome {
    QJKJHomeVC *homeVC = [[QJKJHomeVC alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeVC.navigationItem.title = @"首页";
    homeNav.tabBarItem.title = @"首页";
    
    self.viewControllers = @[ homeNav ];
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
