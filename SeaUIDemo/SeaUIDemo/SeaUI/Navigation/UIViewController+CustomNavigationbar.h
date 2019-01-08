//
//  UIViewController+CustomNavigationbar.h
//  SeaUIDemo
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CustomNavigationbar)

/// 导航栏背景色
@property(nonatomic, strong) UIColor *navigationColor;

/// 左边文字按钮的颜色
@property(nonatomic, strong) UIColor *rightTitleColor;

/// 右边文字按钮的颜色
@property(nonatomic, strong) UIColor *leftTitleColor;

/// 中间标题文字的颜色
@property(nonatomic, strong) UIColor *centerTitleColor;

/// 返回按钮的ImageName
@property(nonatomic,   copy) NSString *backBtnImageName;


/**
 * 右上角按钮处理事件
 */
- (void)rightBarAction;

/**
 * 左上角按钮处理事件
 */
- (void)leftBarAction;

/**
 * 返回按钮处理事件
 */
- (void)backBarAction;

/**
 * 带返回按钮和标题的导航栏
 *
 * @param title 标题内容
 */
- (void)navigationTitle:(NSString *)title;

/**
 * 不带返回按钮和标题的导航栏
 *
 * @param title 标题内容
 */
- (void)navigationNoBackTitle:(NSString *)title;

/**
 * 带返回 按钮 标题 右侧文字按钮 的导航栏
 *
 * @param title      标题内容
 * @param rightTitle 右侧显示文字的按钮
 */
- (void)navigationTitle:(NSString *)title WithRightTitle:(NSString *)rightTitle;

/**
 * 带返回 按钮 标题 右侧图片按钮 的导航栏
 *
 * @param title      标题内容
 * @param rightImage 右侧显示图片的按钮
 */
- (void)navigationTitle:(NSString *)title WithRightItemImage:(UIImage *)rightImage;

/**
 * 带 左侧文字按钮 标题 右侧文字按钮 的导航栏
 *
 * @param title      标题内容
 * @param leftTitle  左侧显示文字的按钮
 * @param rightTitle 右侧显示文字的按钮
 */
- (void)navigationTitle:(NSString *)title LeftTitle:(NSString *)leftTitle RightTitle:(NSString *)rightTitle;

/**
 * 带 左侧按钮 标题 右侧按钮 的导航栏
 *
 * @param title      标题内容
 * @param leftImage  左侧显示图片的按钮
 * @param rightImage 右侧显示图片的按钮
 */
- (void)navigationTitle:(NSString *)title LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage *)rightImage;

/**
 * 带 左侧按钮 自定义标题视图 右侧按钮 的导航栏
 *
 * @param centerView 自定义标题视图
 * @param leftImage  左侧显示图片的按钮
 * @param rightImage 右侧显示图片的按钮
 */
- (void)navigationCenterView:(UIView *)centerView LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage*)rightImage;

@end

NS_ASSUME_NONNULL_END
