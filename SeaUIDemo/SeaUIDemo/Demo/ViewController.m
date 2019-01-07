//
//  ViewController.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/3.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "ViewController.h"
#import "CustorNavigationViewController.h"
#import "SeaSwitchViewController.h"
#import "SeaUI.h"

#define CELL_HINT @[@"原生风格中心弹框",@"原生风格底部弹框",@"原生风格Loading",@"原生风格Toast 带时间控制",@"原生风格Toast",@"可定制Switch",@"自定义导航栏"]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELL_HINT.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = CELL_HINT[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [SeaNativeHUD systemAlertTitle:@"标题" Content:@"内容" Confirm:^{
                NSLog(@"确定");
            }];
            break;
        case 1: {
            NSArray *list = @[@"11",@"12",@"13",@"14",@"15"];
            [SeaNativeHUD systemPopActionSheetList:list CloseTitle:@"关闭" SelectAction:^(NSUInteger selectIndex) {
                NSLog(@"点击%zu",selectIndex);
            }];
            break;
        }
        case 2: {
            [SeaNativeHUD showLoding];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SeaNativeHUD dismissLoading];
            });
            break;
        }
        case 3: {
            [SeaNativeHUD showToast:@"这是提示 Interval:5" Interval:5];
            break;
        }
        case 4: {
            [SeaNativeHUD showToast:@"这是提示"];
            break;
        }
        case 5: {
            [self.navigationController pushViewController:[SeaSwitchViewController new] animated:YES];
            break;
        }
        case 6: {
            [self.navigationController pushViewController:[CustorNavigationViewController new] animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
