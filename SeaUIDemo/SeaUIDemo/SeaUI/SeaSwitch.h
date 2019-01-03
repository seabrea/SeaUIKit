//
//  SeaSwitch.h
//  TYSHBookReader
//
//  Created by Bob on 2019/1/3.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeaSwitch : UIControl

/// On状态 背景填充颜色
@property(nullable, nonatomic, strong) UIColor *onTintColor;
/// Off状态 背景边框颜色
@property(nullable, nonatomic, strong) UIColor *offBordertintColor;
/// 滑动按钮颜色
@property(nullable, nonatomic, strong) UIColor *thumbTintColor;
/// On状态 滑动按钮图像
@property(nullable, nonatomic, strong) UIImage *onImage;
/// Off状态 滑动按钮图像
@property(nullable, nonatomic, strong) UIImage *offImage;
/// Switch状态
@property(nonatomic,getter=isOn) BOOL on;

/**
 设置状态
 
 @param on       设置状态
 @param animated 是否支持动画
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;

/**
 创建Switch控件
 
 @param frame   frame
 @param handler 切换事件
 @return 返回控件
 */
+ (SeaSwitch *)switchFrame:(CGRect)frame WithHandler:(void(^)(BOOL isOn))handler;

/**
 创建默认大小Switch控件(width:51,height:31)
 
 @param handler 切换事件
 @return 返回控件
 */
+ (SeaSwitch *)switchWithHandler:(void(^)(BOOL isOn))handler;

@end

NS_ASSUME_NONNULL_END
