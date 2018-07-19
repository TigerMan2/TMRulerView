//
//  YJRulerView.h
//  YJRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJRulerViewConfig.h"

@interface YJRulerView : UIView

//最大值占位
@property (nonatomic, assign) BOOL isPlaceholderCell_Max;
//最小值占位
@property (nonatomic, assign) BOOL isPlaceholderCell_Min;

@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) NSInteger betweenNumber;
@property (nonatomic, assign) CGFloat step;

@end
