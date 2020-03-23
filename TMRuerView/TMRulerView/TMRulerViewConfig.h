//
//  TMRulerViewConfig.h
//  TMRuerView
//
//  Created by edward lannister on 2018/7/16.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RVCShareIns  [TMRulerViewConfig manager]

@interface TMRulerViewConfig : NSObject

/**
 刻度的间距 默认是50 <10 10等分> = <50 2等分>
 */
@property (nonatomic, assign) CGFloat rulerGap;
/**
 长刻度和Bottom的距离 默认是50
 */
@property (nonatomic, assign) CGFloat rulerLong;
/**
 短刻度和Bottom的距离 默认是80
 */
@property (nonatomic, assign) CGFloat rulerShort;
/**
 刻度尺颜色  红 默认是255.0
 */
@property (nonatomic, assign) CGFloat red;
/**
 刻度尺颜色  蓝 默认是255.0
 */
@property (nonatomic, assign) CGFloat blue;
/**
 刻度尺颜色  黄 默认是255.0
 */
@property (nonatomic, assign) CGFloat green;
/**
 刻度尺颜色  透明度 默认是1.0
 */
@property (nonatomic, assign) CGFloat alpha;
/**
 短刻度的宽度 默认是1
 */
@property (nonatomic, assign) CGFloat rulerShort_W;
/**
 长刻度的宽度 默认是2
 */
@property (nonatomic, assign) CGFloat rulerLong_W;
/**
 刻度文字的大小 默认是17
 */
@property (nonatomic, assign) CGFloat rulerFontSize;
/**
 刻度文字与刻度线的距离 默认是10
 */
@property (nonatomic, assign) CGFloat rulerTitle_Padding;
/**
 刻度文字的高度  默认是30
 */
@property (nonatomic, assign) CGFloat rulerTitle_H;
/**
 刻度文字的颜色 默认是white
 */
@property (nonatomic, strong) UIColor *rulerTitle_Color;
/**
 刻度尺的颜色
 */
@property (nonatomic, strong) UIColor *rulerBgColor;
/**
 刻度尺的标记颜色
 */
@property (nonatomic, strong) UIColor *triangleColor;

/**
 箭头的宽度
 */
@property (nonatomic, assign) CGFloat trangle_W;

/**
 刻度高度
 */
@property (nonatomic, assign) CGFloat rulerView_H;

#pragma mark ------标尺CollectionView的设置------
/**
 间隔值，每两条刻度线相隔多少值
 */
@property (nonatomic, assign) CGFloat step;
/**
 每个区间分为几个小刻度
 */
@property (nonatomic, assign) NSInteger betweenNum;
/**
 最大值
 */
@property (nonatomic, assign) CGFloat maxValue;
/**
 最小值
 */
@property (nonatomic, assign) CGFloat minValue;
/**
 单位
 */
@property (nonatomic, copy) NSString *unit;

+ (instancetype)manager;

@end
