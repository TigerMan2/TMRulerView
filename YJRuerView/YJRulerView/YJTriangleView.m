//
//  YJTriangleView.m
//  YJRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "YJTriangleView.h"

@implementation YJTriangleView

- (void)drawRect:(CGRect)rect {
    //设置背景颜色
    [[UIColor clearColor] set];
    UIRectFill(self.bounds);
    
    //拿到当前试图的画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path路径绘制三角形
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, RVCShareIns.trangle_W, 0);
    CGContextAddLineToPoint(context, RVCShareIns.trangle_W/2, RVCShareIns.trangle_W/2);
    //线结束时绘制端点，有方形:kCGLineCapSquare，圆形:kCGLineCapRound和自然结束:kCGLineCapButt三种
    CGContextSetLineCap(context, kCGLineCapButt);
    //线交叉时设置缺角,有圆角:kCGLineJoinRound，尖角:kCGLineJoinBevel，缺角:kCGLineJoinMiter三种
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextClosePath(context);
    [self.triangleColor setFill];//设置填充色
    [self.triangleColor setStroke];//设置边框色
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
