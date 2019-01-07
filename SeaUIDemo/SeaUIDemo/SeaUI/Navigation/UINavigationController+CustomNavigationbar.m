//
//  UINavigationController+CustomNavigationbar.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/7.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "UINavigationController+CustomNavigationbar.h"
#import <objc/message.h>

static const float leftBarButtonWidth = 44;
static const float titleViewWidth = 100;

#define navigationHeight self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

@implementation UINavigationController (CustomNavigationbar)

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
    [self navigationLeftBarItem:[self drawbackImage]];
    //[self navigationCenterTitle:title TitleColor:[UIColor blackColor]];
}

- (void)navigationNoBackTitle:(NSString *)title {
    
}

- (void)navigationTitle:(NSString *)title WithRightTitle:(NSString *)rightTitle {
    
}

- (void)navigationTitle:(NSString *)title WithRightItemImage:(UIImage *)rightImage {
    
}

- (void)navigationTitle:(NSString *)title LeftTitle:(NSString *)leftTitle RightTitle:(NSString *)rightTitle {
    
}

- (void)navigationTitle:(NSString *)title LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage *)rightImage {
    
}

- (void)navigationCenterView:(UIView *)centerView LeftItemImage:(UIImage *)leftImage RightItemImage:(UIImage*)rightImage {
    
}

#pragma mark - Private Methods

- (void)navigationLeftBarItem:(UIImage*)leftImage {
    
    self.navigationController.navigationBarHidden = NO;
    
    static UIBarButtonItem *leftItem;
    leftItem = nil;
    
    if (!self.backBt) {
        self.backBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBt.frame = CGRectMake(0, 0, leftBarButtonWidth, leftBarButtonWidth);
    }
    
    [self.backBt setImage:leftImage forState:UIControlStateNormal];
    [self.backBt setImage:leftImage forState:UIControlStateHighlighted];
    [self.backBt setImage:leftImage forState:UIControlStateDisabled];
    [self.backBt addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBt];
    self.navigationItem.leftBarButtonItems = @[leftItem];
    
    if(self.popGestureRecognizer) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

- (void)navigationRightImage:(UIImage*)image {
    
    static UIBarButtonItem *rightItem;
    rightItem = nil;
    
    if (!self.rightBt) {
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(0, 0, leftBarButtonWidth, leftBarButtonWidth);
    }
    
    [self.rightBt setBackgroundImage:image forState:UIControlStateNormal];
    [self.rightBt setBackgroundImage:image forState:UIControlStateHighlighted];
    [self.rightBt setBackgroundImage:image forState:UIControlStateDisabled];
    [self.rightBt addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBt];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)navigationRightTitle:(NSString*)title TitleColor:(UIColor *)color{
    
    static UIBarButtonItem *rightItem;
    rightItem = nil;
    
    if (!self.rightBt) {
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(0, 0, 58, 32);
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

- (void)navigationLeftTitle:(NSString*)title TitleColor:(UIColor *)color{
    
    static UIBarButtonItem *leftItem;
    leftItem = nil;
    
    if (!self.backBt) {
        self.backBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBt.frame = CGRectMake(0, 0, leftBarButtonWidth, leftBarButtonWidth);
    }
    
    self.backBt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.backBt setTitleColor:color forState:UIControlStateNormal];
    [self.backBt setTitleColor:[color colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [self.backBt setTitle:title forState:UIControlStateNormal];
    [self.backBt addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBt];
    self.navigationItem.rightBarButtonItem = leftItem;
    
    [self.rightBt setTitle:title forState:UIControlStateNormal];
    
}

- (void)navigationCenterTitle:(NSString*)title TitleColor:(UIColor *)color  {
    
    if (!self.titleLb) {
        self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleViewWidth, navigationHeight)];
    }
    if(!color) {
        color = [UIColor blackColor];
    }
    self.titleLb.textColor = color;
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.font = [UIFont systemFontOfSize:18];
    self.titleLb.text = title;
    
    UIView *titleContentview = [[UIView alloc] init];
    [titleContentview setBackgroundColor:[UIColor clearColor]];
    [titleContentview addSubview:self.titleLb];
    [self makeConstraintsSubView:self.titleLb SupView:titleContentview];
    self.navigationItem.titleView = titleContentview;
}

- (void)navigationBackgroundColor:(UIColor *)color {
    
    if(!color) {
        color = [UIColor blackColor];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

- (void)makeConstraintsSubView:(UIView *)subView SupView:(UIView *)supView {

    NSLayoutConstraint *subViewheightConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    NSLayoutConstraint *subViewWidthConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:200];
    NSLayoutConstraint *subViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:supView attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
        NSLayoutConstraint *subViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:supView attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
    [subView addConstraint:subViewheightConstraint];
    [subView addConstraint:subViewWidthConstraint];
    [subView addConstraint:subViewCenterXConstraint];
    [subView addConstraint:subViewCenterYConstraint];
}

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

- (UIImage *)drawbackImage {

    UIGraphicsBeginImageContext(CGSizeMake(leftBarButtonWidth, leftBarButtonWidth));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextMoveToPoint(context, 22, 22);
    CGContextAddLineToPoint(context, 44, 0);
    CGContextMoveToPoint(context, 22, 22);
    CGContextAddLineToPoint(context, 44, 44);
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

- (UIButton *)backBt {
    return  objc_getAssociatedObject(self, @selector(backBt));
}

- (void)setBackBt:(UIButton *)backBt {
    objc_setAssociatedObject(self, @selector(backBt), backBt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)popGestureRecognizer {
    
    NSNumber *boolNumber = objc_getAssociatedObject(self, @selector(popGestureRecognizer));
    return boolNumber.boolValue;
}

- (void)setPopGestureRecognizer:(BOOL)popGestureRecognizer {
    objc_setAssociatedObject(self, @selector(popGestureRecognizer), [NSNumber numberWithBool:popGestureRecognizer], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navigationColor {
    return objc_getAssociatedObject(self, @selector(navigationColor));
}

- (void)setNavigationColor:(UIColor *)navigationColor {
    objc_setAssociatedObject(self, @selector(navigationColor), navigationColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
