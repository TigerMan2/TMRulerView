//
//  TMRulerView.h
//  TMRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMScrollRulerView;
@protocol TMScrollRulerViewDelegate <NSObject>
/*
 *  游标卡尺滑动，对应value回调
 *  滑动视图
 *  当前滑动的值
 */
- (void)sbScrollRulerView:(TMScrollRulerView *)rulerView valueChange:(float)value;
@end

@interface TMScrollRulerView : UIView
/// 代理
@property(nonatomic, weak) id<TMScrollRulerViewDelegate> delegate;
/**
 三角形颜色
 */
@property (nonatomic, strong) UIColor *triangleColor;
/**
 背景颜色
 */
@property (nonatomic, strong) UIColor *bgColor;

/// 初始化对象方法
- (instancetype)initWithFrame:(CGRect)frame minValue:(float)minValue maxValue:(float)maxValue step:(float)step unit:(NSString *)unit num:(NSInteger)betweenNum;

- (void)setRealValue:(CGFloat)value animated:(BOOL)animated;

@end
