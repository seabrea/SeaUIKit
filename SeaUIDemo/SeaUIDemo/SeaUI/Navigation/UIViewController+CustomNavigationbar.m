//
//  UIViewController+CustomNavigationbar.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/8.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "UIViewController+CustomNavigationbar.h"
#import <objc/message.h>

static const float barButtonWidth = 44;
static const float titleViewWidth = 100;

static UIBarButtonItem *leftItem;
static UIBarButtonItem *rightItem;

#define navigationHeight self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

@implementation UIViewController (CustomNavigationbar)

#pragma mark - Interface Methods

- (void)rightBarAction {
}

- (void)leftBarAction {
}

- (void)backBarAction {
    // 使用这个函数的时候必须禁止侧滑,因为侧滑返回时并不会调用这个函数
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationTitle:(NSString *)title {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftBarItem:[UIImage imageNamed:self.backBtnImageName] PopEventState:YES];
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationNoBackTitle:(NSString *)title {
    
    [self navigationBackgroundColor:self.navigationColor];
    
    UIView *emptyView = [[UIView alloc] init];
    emptyView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:emptyView];
    
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationTitle:(NSString *)title WithRightTitle:(NSString *)rightTitle {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftBarItem:[UIImage imageNamed:self.backBtnImageName] PopEventState:YES];
    [self navigationRightTitle:rightTitle TitleColor:self.rightTitleColor];
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationTitle:(NSString *)title WithRightItemImage:(UIImage *)rightImage {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftBarItem:[UIImage imageNamed:self.backBtnImageName] PopEventState:YES];
    [self navigationRightImage:rightImage];
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationTitle:(NSString *)title LeftTitle:(NSString *)leftTitle RightTitle:(NSString *)rightTitle {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftTitle:leftTitle TitleColor:self.leftTitleColor];
    [self navigationRightTitle:rightTitle TitleColor:self.rightTitleColor];
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationTitle:(NSString *)title LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage *)rightImage {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftBarItem:leftImage PopEventState:NO];
    [self navigationRightImage:rightImage];
    [self navigationCenterTitle:title TitleColor:self.centerTitleColor];
}

- (void)navigationCenterView:(UIView *)centerView LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage*)rightImage {
    
    [self navigationBackgroundColor:self.navigationColor];
    [self navigationLeftBarItem:[UIImage imageNamed:self.backBtnImageName] PopEventState:YES];
    self.navigationItem.titleView = centerView;
    [self navigationRightImage:rightImage];
}

#pragma mark - Private Methods

- (void)navigationLeftBarItem:(UIImage *)leftImage PopEventState:(BOOL)isPop {
    
    if(!leftImage) {
        leftImage = [self drawbackImage];
    }
    
    self.navigationController.navigationBarHidden = NO;
    
    leftItem = nil;
    
    if (!self.leftBt) {
        self.leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth);
        self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    [self.leftBt setImage:leftImage forState:UIControlStateNormal];
    [self.leftBt setImage:leftImage forState:UIControlStateHighlighted];
    [self.leftBt setImage:leftImage forState:UIControlStateDisabled];
    
    [self.leftBt addTarget:self
                    action:isPop ? @selector(backBarAction) : @selector(leftBarAction)
          forControlEvents:UIControlEventTouchUpInside];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)navigationRightImage:(UIImage *)image {
    
    if(!image) {
        return;
    }
    
    rightItem = nil;
    
    if (!self.rightBt) {
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth);
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    [self.rightBt setImage:image forState:UIControlStateNormal];
    [self.rightBt setImage:image forState:UIControlStateHighlighted];
    [self.rightBt setImage:image forState:UIControlStateDisabled];
    
    [self.rightBt addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)navigationRightTitle:(NSString *)title TitleColor:(UIColor *)color {
    
    rightItem = nil;
    
    if(!color) {
        color = [UIColor blackColor];
    }
    
    if (!self.rightBt) {
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth);
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    self.rightBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.rightBt setTitleColor:color forState:UIControlStateNormal];
    [self.rightBt setTitleColor:[color colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [self.rightBt setTitle:title forState:UIControlStateNormal];
    [self.rightBt addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.rightBt setTitle:title forState:UIControlStateNormal];
    
}

- (void)navigationLeftTitle:(NSString *)title TitleColor:(UIColor *)color{
    
    leftItem = nil;
    
    if(!color) {
        color = [UIColor blackColor];
    }
    
    if (!self.leftBt) {
        self.leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth);
        self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    self.leftBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.leftBt setTitleColor:color forState:UIControlStateNormal];
    [self.leftBt setTitleColor:[color colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [self.leftBt setTitle:title forState:UIControlStateNormal];
    [self.leftBt addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBt];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.leftBt setTitle:title forState:UIControlStateNormal];
    
}

- (void)navigationCenterTitle:(NSString *)title TitleColor:(UIColor *)color  {
    
    CGFloat contentViewHeight = self.navigationController.navigationBar.frame.size.height;
    
    if (!self.titleLb) {
        self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleViewWidth, contentViewHeight)];
    }
    
    if(!color) {
        color = [UIColor blackColor];
    }
    self.titleLb.textColor = color;
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.font = [UIFont systemFontOfSize:18];
    self.titleLb.text = title;
    
    UIView *titleContentview = [[UIView alloc] init];
    titleContentview.frame = CGRectMake(0, 0, titleViewWidth, contentViewHeight);
    [titleContentview setBackgroundColor:[UIColor clearColor]];
    [titleContentview addSubview:self.titleLb];
    [self makeConstraintsSubView:self.titleLb SupView:titleContentview Size:CGSizeMake(titleViewWidth, contentViewHeight)];
    self.navigationItem.titleView = titleContentview;
}

- (void)navigationBackgroundColor:(UIColor *)color {
    
    if(!color) {
        color = [UIColor whiteColor];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

// 为导航栏中间视图添加约束
- (void)makeConstraintsSubView:(UIView *)subView SupView:(UIView *)supView Size:(CGSize)size {
    
    if(!subView || !supView) {
        return;
    }
    
    supView.translatesAutoresizingMaskIntoConstraints = NO;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [supView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sub(100)]-0-|" options:kNilOptions metrics:nil views:@{@"sub":subView,@"width":[NSNumber numberWithFloat:size.height]}]];
    [supView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sub(44)]-0-|" options:kNilOptions metrics:nil views:@{@"sub":subView,@"height":[NSNumber numberWithFloat:size.width]}]];
}

// 根据颜色生成Image
- (UIImage *)imageWithColor:(UIColor *)color {
    
    if (!color) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 生成默认返回图案
- (UIImage *)drawbackImage {
    
    UIGraphicsBeginImageContext(CGSizeMake(barButtonWidth, barButtonWidth));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextMoveToPoint(context, 5, 22);
    CGContextAddLineToPoint(context, 15, 13);
    CGContextMoveToPoint(context, 5, 22);
    CGContextAddLineToPoint(context, 15, 31);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - gett setter

-(UIButton *)rightBt {
    return objc_getAssociatedObject(self, @selector(rightBt));
}

-(void)setRightBt:(UIButton *)rightBt {
    objc_setAssociatedObject(self, @selector(rightBt), rightBt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)titleLb {
    return  objc_getAssociatedObject(self, @selector(titleLb));
}

- (void)setTitleLb:(UILabel *)titleLb {
    objc_setAssociatedObject(self, @selector(titleLb), titleLb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)leftBt {
    return objc_getAssociatedObject(self, @selector(leftBt));
}

- (void)setLeftBt:(UIButton *)leftBt {
    objc_setAssociatedObject(self, @selector(leftBt), leftBt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navigationColor {
    return objc_getAssociatedObject(self, @selector(navigationColor));
}

- (void)setNavigationColor:(UIColor *)navigationColor {
    objc_setAssociatedObject(self, @selector(navigationColor), navigationColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)rightTitleColor {
    return objc_getAssociatedObject(self, @selector(rightTitleColor));
}

- (void)setRightTitleColor:(UIColor *)rightTitleColor {
    objc_setAssociatedObject(self, @selector(rightTitleColor), rightTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)leftTitleColor {
    return objc_getAssociatedObject(self, @selector(leftTitleColor));
}

- (void)setLeftTitleColor:(UIColor *)leftTitleColor {
    objc_setAssociatedObject(self, @selector(leftTitleColor), leftTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)centerTitleColor {
    return objc_getAssociatedObject(self, @selector(centerTitleColor));
}

- (void)setCenterTitleColor:(UIColor *)centerTitleColor {
    objc_setAssociatedObject(self, @selector(centerTitleColor), centerTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)backBtnImageName {
    return objc_getAssociatedObject(self, @selector(backBtnImageName));
}

- (void)setBackBtnImageName:(NSString *)backBtnImageName {
    objc_setAssociatedObject(self, @selector(backBtnImageName), backBtnImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
