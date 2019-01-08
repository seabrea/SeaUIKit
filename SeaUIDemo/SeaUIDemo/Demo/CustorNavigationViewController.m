//
//  CustorNavigationViewController.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/7.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "CustorNavigationViewController.h"
#import "UIViewController+CustomNavigationbar.h"

#define CELL_HINT @[@"类型1",@"类型2",@"类型3",@"类型4",@"类型5",@"类型6",@"类型17"]

@interface CustorNavigationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CustorNavigationViewController

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
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    vc.popGestureRecognizer = YES;
    vc.navigationColor = [UIColor greenColor];
    vc.rightTitleColor = [UIColor grayColor];
    vc.leftTitleColor = [UIColor orangeColor];
    vc.centerTitleColor = [UIColor blackColor];
    vc.backBtnImageName = @"back";
    
    switch (indexPath.row) {
        case 0: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationTitle:@"标题"];
            break;
        }
        case 1: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationNoBackTitle:@"标题"];
            break;
        }
        case 2: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationTitle:@"标题" WithRightTitle:@"右标题"];
            break;
        }
        case 3: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationTitle:@"标题" WithRightItemImage:[UIImage imageNamed:@"right"]];
            break;
        }
        case 4: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationTitle:@"标题" LeftTitle:@"左边标题" RightTitle:@"右边标题"];
            break;
        }
        case 5: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc navigationTitle:@"标题" LeftItemImage:[UIImage imageNamed:@"left"] RightItemImage:[UIImage imageNamed:@"right"]];
            break;
        }
        case 6: {
            [self.navigationController pushViewController:vc animated:YES];
            UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
            centerView.backgroundColor = [UIColor orangeColor];
            [vc navigationCenterView:centerView LeftItemImage:[UIImage imageNamed:@"left"] RightItemImage:[UIImage imageNamed:@"right"]];
            break;
        }
        default:
            break;
    }
}

@end
