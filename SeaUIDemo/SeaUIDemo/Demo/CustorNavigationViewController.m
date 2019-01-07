//
//  CustorNavigationViewController.m
//  SeaUIDemo
//
//  Created by Bob on 2019/1/7.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "CustorNavigationViewController.h"
#import "ShowCustorNavigationViewController.h"
#import "UINavigationController+CustomNavigationbar.h"

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
    
    ShowCustorNavigationViewController *vc = [[ShowCustorNavigationViewController alloc] init];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        case 1: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        case 2: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        case 3: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        case 4: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        case 5: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        case 6: {
            [self.navigationController pushViewController:vc animated:YES];
            [vc.navigationController navigationTitle:@"标题"];
            break;
        }
        default:
            break;
    }
}

@end
