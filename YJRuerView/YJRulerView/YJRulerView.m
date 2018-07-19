//
//  YJRulerView.m
//  YJRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "YJRulerView.h"
#import "YJRulerViewConfig.h"

@implementation YJRulerView

//绘制刻度
- (void)drawRect:(CGRect)rect {
    
    CGFloat startX = 0;
    CGFloat lineCenterX = RVCShareIns.rulerGap;
    CGFloat shortLineY = rect.size.height - RVCShareIns.rulerShort;
    CGFloat longLineY = rect.size.height - RVCShareIns.rulerLong;
    CGFloat topY = 0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, RVCShareIns.red/255.0, RVCShareIns.green/255.0, RVCShareIns.blue/255.0, RVCShareIns.alpha);
    
    for (int i = 0; i <= _betweenNumber; i ++) {
        //用来标记cell是否需要绘制刻度，第一个cell只需要绘制最后一个长刻度，最后一个cell只需要绘制第一个长刻度。
        BOOL isGrawLine = YES;
        if (self.isPlaceholderCell_Max) {
            if (i != 0) {
                isGrawLine = NO;
            } else {
                //绘制最后一个cell的第一个长刻度
                CGContextMoveToPoint(context, startX + lineCenterX * i, topY);
            }
        } else if (self.isPlaceholderCell_Min) {
            if (i != _betweenNumber) {
                isGrawLine = NO;
            } else {
                //绘制第一个cell的最后一个长刻度
                CGContextMoveToPoint(context, rect.size.width, topY);
            }
        } else {
            //其他cell的所有刻度都绘制
            CGContextMoveToPoint(context, startX+lineCenterX*i, topY);
        }
        
        if (i % _betweenNumber == 0) {//长刻度绘制
            CGContextSetLineWidth(context, RVCShareIns.rulerLong_W);//设置长刻度的宽度
            NSString *num = [NSString stringWithFormat:@"%.f",i * _step + _minValue];
            if ([num floatValue] > 1000000){///过长文本处理
                num = [NSString stringWithFormat:@"%.f万",[num floatValue]/10000.f];
            }
            if (isGrawLine) {
                NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize:RVCShareIns.rulerFontSize], NSForegroundColorAttributeName : RVCShareIns.rulerTitle_Color};
                CGFloat width = [num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
                if (self.isPlaceholderCell_Min) {
                    CGContextAddLineToPoint(context, rect.size.width, longLineY);
                    [num drawInRect:CGRectMake(rect.size.width - width / 2, longLineY + RVCShareIns.rulerTitle_Padding, width, RVCShareIns.rulerTitle_H) withAttributes:attribute];
                } else {
                    CGContextAddLineToPoint(context, startX + lineCenterX * i, longLineY);
                    [num drawInRect:CGRectMake(startX + lineCenterX * i - width / 2, longLineY + RVCShareIns.rulerTitle_Padding, width, RVCShareIns.rulerTitle_H) withAttributes:attribute];
                }
            }
        } else {//短刻度绘制
            if (!self.isPlaceholderCell_Min && !self.isPlaceholderCell_Max) {
                CGContextSetLineWidth(context, RVCShareIns.rulerShort_W);//设置短刻度的宽度
                CGContextAddLineToPoint(context, startX + lineCenterX * i, shortLineY);
            }
        }
        CGContextStrokePath(context);//开始绘制
    }
    
}

@end
