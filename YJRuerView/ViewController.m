//
//  ViewController.m
//  YJRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "ViewController.h"
#import "YJScrollRulerView.h"
#import "YJRulerViewConfig.h"

@interface ViewController ()

@property (nonatomic, strong) YJScrollRulerView *rulerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rulerView];
    
}

- (YJScrollRulerView *)rulerView {
    if (!_rulerView) {
        _rulerView = [[YJScrollRulerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 0 * 2, RVCShareIns.rulerView_H) minValue:0 maxValue:10 step:0.5 unit:@"" num:2];
        _rulerView.center = self.view.center;
        [_rulerView setRealValue:5 animated:YES];
    }
    return _rulerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
