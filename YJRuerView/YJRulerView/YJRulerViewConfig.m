//
//  YJRulerViewConfig.m
//  YJRuerView
//
//  Created by edward lannister on 2018/7/16.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "YJRulerViewConfig.h"

@implementation YJRulerViewConfig

+ (instancetype)manager {
    static YJRulerViewConfig *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance defaultSetup];
    });
    return _instance;
}
/**
 初始配置
 */
- (void)defaultSetup {
    self.rulerGap = 50;
    self.rulerLong = 50;
    self.rulerShort = 80;
    self.red = 255.0;
    self.green = 255.0;
    self.blue = 255.0;
    self.alpha = 1.0;
    self.rulerShort_W = 1;
    self.rulerLong_W = 2;
    self.rulerFontSize = 17;
    self.rulerTitle_Padding = 10;
    self.rulerTitle_H = 30;
    self.rulerTitle_Color = [UIColor whiteColor];
    self.rulerBgColor = [UIColor orangeColor];
    self.triangleColor = [UIColor whiteColor];
    self.trangle_W = 25;
    self.rulerView_H = 100;
}

@end
