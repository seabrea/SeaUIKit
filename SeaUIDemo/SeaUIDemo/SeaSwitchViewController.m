//
//  SeaSwitchViewController.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/3.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "SeaSwitchViewController.h"
#import "SeaUI/SeaSwitch.h"

@interface SeaSwitchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UISlider *slideView;
@property(nonatomic, strong) SeaSwitch *seaSwitch;

@end

@implementation SeaSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self)weakSelf = self;
    self.seaSwitch = [SeaSwitch switchWithHandler:^(BOOL isOn) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.stateLabel.text = isOn ? @"YES" : @"NO";
    }];
    self.seaSwitch.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.seaSwitch.center = self.view.center;
    [self.view addSubview:self.seaSwitch];
}

- (IBAction)changeSlider:(UISlider *)sender {
    
    CGRect newFrame = self.seaSwitch.frame;
    newFrame.size.width = 51 + 100 * sender.value;
    newFrame.size.height = 31 + 100 * sender.value;
    self.seaSwitch.frame = newFrame;
}

@end
