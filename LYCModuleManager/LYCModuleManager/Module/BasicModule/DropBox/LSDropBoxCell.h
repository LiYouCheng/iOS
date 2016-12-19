//
//  LSDropBoxCell.h
//  LYCModuleManager
//
//  Created by 史ios on 16/12/19.
//  Copyright © 2016年 深圳市齐家互联网科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDropBoxCell : UITableViewCell

/**
 *  刷新图片和名称
 *
 *  @param imageName 图片名字
 *  @param name      名字
 */
- (void)refreshUIWithImageName:(NSString *)imageName
                      withName:(NSString *)name;

@end
