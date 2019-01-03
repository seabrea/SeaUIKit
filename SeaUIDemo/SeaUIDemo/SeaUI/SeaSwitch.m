//
//  SeaSwitch.m
//  TYSHBookReader
//
//  Created by Bob on 2019/1/3.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "SeaSwitch.h"

const CGSize defaultSwitchSize = {51,31};

@interface SeaSwitch()

@property(nonatomic, strong) CALayer *thumbLayer;
@property(nonatomic, strong) CALayer *onLayer;
@property(nonatomic, strong) CALayer *offLayer;

@property(nonatomic, assign) CGRect curFrame;

@property(nonatomic, copy) void (^switchHandler)(BOOL isOn);

@end

@implementation SeaSwitch

#pragma mark - Class Methods

+ (SeaSwitch *)switchWithHandler:(void(^)(BOOL isOn))handler {
    return [SeaSwitch switchFrame:CGRectMake(100, 100, defaultSwitchSize.width, defaultSwitchSize.height) WithHandler:handler];
}

+ (SeaSwitch *)switchFrame:(CGRect)frame WithHandler:(void(^)(BOOL isOn))handler {
    
    if(CGRectGetWidth(frame) <= CGRectGetHeight(frame)) {
        frame = CGRectMake(100, 100, defaultSwitchSize.width, defaultSwitchSize.height);
    }
    SeaSwitch *switchView = [[SeaSwitch alloc] initWithFrame:frame];
    switchView.switchHandler = handler;
    return switchView;
}


#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self configureLogicWithFrame:frame];
        [self configureViewWithFrame:frame];
    }
    return self;
}


#pragma mark - Private Methods

- (void)configureLogicWithFrame:(CGRect)configureFrame {
    
    self.on = NO;
    self.curFrame = configureFrame;
    self.onTintColor = [UIColor colorWithRed:230.0/255 green:126.0/255 blue:34.0/255 alpha:1];
    self.offBordertintColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    [self addTarget:self action:@selector(onClickEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
}

- (void)configureViewWithFrame:(CGRect)configureFrame {
    
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1].CGColor;
    self.layer.cornerRadius = CGRectGetHeight(configureFrame) / 2;
    
    self.thumbLayer = [[CALayer alloc] init];
    self.thumbLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.thumbLayer.anchorPoint = CGPointZero;
    self.thumbLayer.frame = CGRectMake(0, 0, CGRectGetHeight(configureFrame), CGRectGetHeight(configureFrame));
    self.thumbLayer.cornerRadius = CGRectGetHeight(configureFrame) / 2;
    self.thumbLayer.shadowColor = [UIColor grayColor].CGColor;
    self.thumbLayer.shadowOffset = CGSizeMake(0, 1);
    self.thumbLayer.shadowOpacity=0.5;
    [self.layer addSublayer:self.thumbLayer];

    self.onLayer = [[CALayer alloc] init];
    self.onLayer.anchorPoint = CGPointZero;
    self.onLayer.cornerRadius = CGRectGetHeight(self.thumbLayer.bounds) / 2;
    self.onLayer.frame = self.thumbLayer.bounds;
    [self.thumbLayer addSublayer:self.onLayer];
    self.onLayer.hidden = YES;
    
    self.offLayer = [[CALayer alloc] init];
    self.offLayer.anchorPoint = CGPointZero;
    self.offLayer.cornerRadius = CGRectGetHeight(self.thumbLayer.bounds) / 2;
    self.offLayer.frame = self.thumbLayer.bounds;
    [self.thumbLayer addSublayer:self.offLayer];
    self.offLayer.hidden = YES;
}

- (void)onClickEvent:(UIButton *)sender {
    [self setOn:!self.isOn animated:YES];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    if(self.isOn == on) {
        return;
    }
    
    self.on = on;
    
    if(animated) {
        [UIView animateWithDuration:0.1f animations:^{
            [self thumbLayerFrameChangeWithState:self.isOn];
        } completion:^(BOOL finished) {
            self.switchHandler(on);
        }];
    }
    else {
        [self thumbLayerFrameChangeWithState:self.isOn];
        self.switchHandler(on);
    }
}

- (void)thumbLayerFrameChangeWithState:(BOOL)isOn {
    if(isOn) {
        self.thumbLayer.frame = CGRectMake(CGRectGetWidth(self.curFrame) - CGRectGetHeight(self.curFrame), 0, CGRectGetHeight(self.curFrame), CGRectGetHeight(self.curFrame));
    }
    else {
        self.thumbLayer.frame = CGRectMake(0, 0, CGRectGetHeight(self.curFrame), CGRectGetHeight(self.curFrame));
    }
    self.onLayer.hidden = !isOn;
    self.offLayer.hidden = isOn;
    self.layer.backgroundColor = isOn ? self.onTintColor.CGColor : [UIColor whiteColor].CGColor;
    self.layer.borderColor =  isOn ? [UIColor clearColor].CGColor : self.offBordertintColor.CGColor;
}


#pragma mark - Setter

- (void)setFrame:(CGRect)frame {
    
    CGSize thumbLayerSize = CGSizeMake(CGRectGetHeight(frame), CGRectGetHeight(frame));
    CGRect thumbLayerFrame = self.thumbLayer.frame;
    
    self.layer.cornerRadius = thumbLayerSize.height / 2;
    
    thumbLayerFrame.size = thumbLayerSize;
    self.thumbLayer.frame = thumbLayerFrame;
    self.thumbLayer.cornerRadius = thumbLayerSize.height / 2;
    
    self.onLayer.cornerRadius = thumbLayerSize.height / 2;
    self.onLayer.frame = self.thumbLayer.bounds;
    
    self.offLayer.cornerRadius = thumbLayerSize.height / 2;
    self.offLayer.frame = self.thumbLayer.bounds;
    
    self.curFrame = frame;
    
    [super setFrame:frame];
}

- (void)setOnImage:(UIImage *)onImage {
    
    self.onLayer.contents = CFBridgingRelease(onImage.CGImage);
    self.onLayer.contentsGravity = kCAGravityResizeAspectFill;
    self.onLayer.hidden = !self.isOn;
}

- (void)setOffImage:(UIImage *)offImage {

    self.offLayer.contents = CFBridgingRelease(offImage.CGImage);
    self.offLayer.contentsGravity = kCAGravityResizeAspectFill;
    self.offLayer.hidden = self.isOn;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    self.thumbLayer.backgroundColor = thumbTintColor.CGColor;
}

- (void)setOnTintColor:(UIColor *)onTintColor {
    
    _onTintColor = onTintColor;
    if(self.isOn) {
        self.layer.backgroundColor = onTintColor.CGColor;
    }
}

- (void)setOffBordertintColor:(UIColor *)offBordertintColor {
    
    _offBordertintColor = offBordertintColor;
    if(!self.isOn) {
        self.layer.borderColor = offBordertintColor.CGColor;
    }
}

@end
