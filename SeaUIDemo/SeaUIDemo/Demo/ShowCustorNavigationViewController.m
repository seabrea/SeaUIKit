//
//  ShowCustorNavigationViewController.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/7.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "ShowCustorNavigationViewController.h"
#import "UINavigationController+CustomNavigationbar.h"

@interface ShowCustorNavigationViewController ()

@end

@implementation ShowCustorNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController navigationTitle:@"标题"];
}

@end
